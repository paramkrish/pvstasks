class CommentsController < ApplicationController

  def index

    @task = Task.find(params[:task_id])
    @comments = @task.comments.all
    # respond_to do |format|
    #    format.html { redirect_to task_path(@task) }
    #    format.js 
    #render :layout => false
    #end

  end

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(comment_params)

         respond_to do |format|
            format.html { redirect_to task_path(@task) }
            format.js 
  
          end
  end

  def destroy
    @task = Task.find(params[:task_id])
    @comment = @task.comments.find(params[:id])
    @comment.destroy
    redirect_to task_path(@task)
  end

  private
  def comment_params
    params.require(:comment).permit(:username,:comments)
  end


end
