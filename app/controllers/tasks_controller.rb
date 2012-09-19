class TasksController < ApplicationController


  def index
    @todo   = user_tasks.where(:done => false)
    @task   = Task.new
    @lists  = user_lists
    @list   = List.new
    
    respond_to do |format|
      format.html
    end
  end


  def create
    @list = user_lists.find(params[:list_id])
    @task = @list.tasks.new(params[:task])
    @task.user = current_user if current_user
    if @task.save
        flash[:notice] = "Your task was created."
    else
        flash[:alert] = "There was an error creating your task."
    end
    redirect_to(list_tasks_url(@list))
  end
  

  def update
    @list = user_lists.find(params[:list_id])
    @task = @list.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to( list_tasks_url(@list), :notice => 'Task was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @task = user_tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(list_tasks_url(@list)) }
    end
  end

  private
  def user_lists
    if current_user
      current_user.lists
    else
      List.guest_lists
    end
  end
  
  def user_tasks
    if current_user
      current_user.tasks
    else
      Task.guest_tasks
    end
  end
end
