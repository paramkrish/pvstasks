class TasksController < ApplicationController

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(user_params)
    if @task.save
      flash[:success] =  "New task created"
      redirect_to tasks_path
    else
      render "new"
    end
  end


  def edit
    @task = Task.find(params[:id])
  end

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    #if @task.update_attributes(:name => "New") 
    if @task.update_attributes(user_params)
      flash[:success] = "Your task is Updated."
      redirect_to task_path
    else
      render "edit"
    end

  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:danger] = "That task is deleted."
    redirect_to tasks_path
  end

  def user_params
    params.require(:task).permit(:title,:due_date)
  end

end
