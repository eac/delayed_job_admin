module DelayedJobAdmin
  module Config

    # Specify the controller DelayedAdmin controllers inherit from
    # Redefine in app/lib/delayed_admin/config.rb:
    # module DelayedAdmin::Config
    #   def self.parent_controller_class() AdminController end
    # end
    def self.parent_controller_class
      ActionController::Base
    end
    
  end
end