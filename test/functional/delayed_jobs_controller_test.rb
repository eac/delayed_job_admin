require 'test_helper'
class DelayedJobsControllerTest < ActionController::TestCase
  
  context "getting the index" do
    setup do
      @job = Object.send_later(:inspect)
    end
  
    should "succeed" do
      get :index
      assert_response :success
    end
  end
  
  context "destroying a job" do
    
    setup do
      @job = Object.send_later(:inspect)
    end
  
    context "with HTML format" do
      should "redirect to admin_jobs_path" do
        delete :destroy, :id => @job.to_param
        assert_redirected_to delayed_jobs_path
      end
      
      should "flash a success message" do
        delete :destroy, :id => @job.to_param
        assert_match /Job destroyed/, flash[:success]
      end
      
      should "destroy the job" do
        delete :destroy, :id => @job.to_param
        assert_raise ActiveRecord::RecordNotFound do
          @job.reload
        end
      end
    end
    
    context "with JSON format" do
      should "respond with 204 No Content" do
        delete :destroy, :id => @job.to_param, :format => 'json'
        assert_response :no_content
      end
      
      should "destroy the job" do
        delete :destroy, :id => @job.to_param, :format => 'json'
        assert_raise ActiveRecord::RecordNotFound do
          @job.reload
        end
      end
    end
    
  end
    
end