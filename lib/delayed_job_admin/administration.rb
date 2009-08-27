module DelayedJobAdmin
  module Administration
    HANDLER_IGNORE_PATTERN = /--- !ruby\/object:/
    
    def self.included(base)
      base.__send__(:extend, Statistics)
    end
    
    def humanized_handler
      handler.sub(HANDLER_IGNORE_PATTERN, '')
    end
    
    def statuses
      statuses = []
      statuses << :failed if failed?
      statuses << :locked if locked_at?
      statuses
    end
    
    module Statistics
      def self.extended(base)
        base.instance_eval do
          
          named_scope :failed,  :conditions => 'failed_at is not null'
          named_scope :locked,  :conditions => 'locked_at is not null' 
        
        end
      end
      
      def statistics
        stats = ActiveSupport::OrderedHash.new
        stats[:failed] = failed.count
        stats[:locked] = locked.count
        stats[:total]  = count
        stats
      end
    end
  
  end
end