require 'test_helper'

class JobAdministrationTest < ActiveSupport::TestCase

  context "Administration" do
    setup do
      @job = Delayed::Job.new
    end
    
    context "statuses" do
      
      should "include :failed and :locked when failed and locked" do
        @job.failed_at = DateTime.now
        @job.locked_at = DateTime.now
                  
        assert_equal [ :failed, :locked ], @job.statuses
      end
      
      should "not include locked when not locked" do
        @job.failed_at = DateTime.now
        
        assert_equal [ :failed ], @job.statuses
      end
      
      should "not include failed when not failed" do
        @job.locked_at = DateTime.now
        
        assert_equal [ :locked ], @job.statuses
      end
      
      should "return an empty array when neither failed nor locked" do          
        assert_equal [], @job.statuses
      end
      
    end
  
    context "humanized handler" do
    
      should "provide the handler without its ruby object identifier" do
        @job.handler = '--- !ruby/object:TestJob {}'
        assert_equal 'TestJob {}', @job.humanized_handler
      end
    
    end
    
    context "model statistics" do
      setup do
        failed_job               = create_delayed_job(:failed_at => Time.now)         
        locked_job               = create_delayed_job(:locked_at => Time.now)
        locked_and_failed_job    = create_delayed_job(:locked_at => Time.now, :failed_at => Time.now)
        not_locked_or_failed_job = create_delayed_job
        
        @failed_jobs = [ failed_job, locked_and_failed_job ]
        @locked_jobs = [ locked_job, locked_and_failed_job ]
      end
      
      context "named scopes" do 
        
        should "only include failed jobs in :failed scope" do
          assert_equal @failed_jobs, Delayed::Job.failed
        end
        
        should "only include locked jobs in :locked scope" do
          assert_equal @locked_jobs, Delayed::Job.locked
        end
        
      end
      
      context "statistics" do
        setup do
          @stats = Delayed::Job.statistics
        end
         
        should "correctly count :failed jobs" do
          assert_equal @failed_jobs.size, @stats[:failed]
        end
        
        should "correctly count of :total jobs" do
          assert_equal Delayed::Job.count, @stats[:total]
        end
        
        should "correctly count of :locked jobs" do
          assert_equal @locked_jobs.size, @stats[:locked]
        end
        
        should "be ordered :failed, :locked, then :total" do
          assert_equal [ :failed, :locked, :total ], @stats.keys
        end
        
      end    
    end
    
  end
  
  protected
  
  # Test Job via delayed_job's job_spec.rb
  class ErrorJob
    cattr_accessor :runs; self.runs = 0
    def perform; raise 'did not work'; end
  end
  
  def create_delayed_job(attributes = {})
    job = Delayed::Job.enqueue ErrorJob.new
    job.__send__(:attributes=, attributes, guard_from_mass_assignment = false)
    job.save!
    job
  end
  
end