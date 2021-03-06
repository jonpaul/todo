class TasksController < ApplicationController
  
  before_filter :get_project
  
  respond_to :html, :js
  
  def create
    @task = @project.tasks.new(params[:task])
    @task.save
    respond_with(@task, :layout => !request.xhr? )
  end
  
  def complete
    @task = @project.tasks.find(params[:id])
    @task.update_attribute(:completed, true)
    respond_with(@task, :layout => !request.xhr?)
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    Task.destroy(@task) if @task
    @id = params[:id]
    respond_with(@id, :layout => !request.xhr?)
  end
  
  def sort
    @project.tasks.incomplete.each do |task|
      task.update_attribute(:position, params['task'].index(task.id.to_s) + 1)
    end
    render :nothing => true
  end
  
end
