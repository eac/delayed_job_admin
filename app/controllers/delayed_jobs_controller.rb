class DelayedJobsController < DelayedJobAdmin::Config.parent_controller_class
  unloadable
  
  def index
    @statistics = current_model.statistics
    @jobs       = current_model.all
    
    respond_to do |format|
      format.html
      format.json { render :json => @jobs }
    end
  end
  
  def destroy
    @job = current_job
    @job.destroy
    flash[:success] = "Job destroyed (##{@job.to_param})"

    respond_to do |format|
      format.html  { redirect_to delayed_jobs_path }
      format.json  { head :no_content      }
    end
  end
  
  protected
  
  def current_job
    current_model.find(params[:id])
  end
  
  def current_model
    Delayed::Job
  end
  
end
