class ListsController < ApplicationController

  def create
    @list = user_lists.new(params[:list])
    @list.user = current_user if current_user
    if @list.save
        flash[:notice] = "Your list was created"
    else
        flash[:alert] = "There was an error creating your list."
    end
    redirect_to(list_tasks_url(@list))
  end

  def destroy
    @list = user_lists.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
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

end
