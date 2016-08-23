class TasksController < ApplicationController
  helper_method :closed_tasks, :update_task
  has_scope :status

  @all_users  = "Param"

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(user_params)
    @task.update_attributes(:status =>0) 

    if @task.save
      flash[:success] =  "New Task <strong>'#{@task.title}'</strong> is created successfully"
      redirect_to tasks_path
    else
      render "new"
    end
  end


  def edit
    @task = Task.find(params[:id])
  end

  def index
  @current_view = "All Tasks"
  @tasks = Task.where(nil) # creates an anonymous scope
  @tasks = @tasks.status(params[:status]) if params[:status].present?
  @tasks = @tasks.owner(params[:owner]) if params[:owner].present?
  @tasks = @tasks.priority(params[:priority]) if params[:priority].present?
  if params[:status].present?
    params[:status] == "0" ? @current_view = "Open Tasks" : @current_view = "Closed Tasks"
  end
  #@tasks = @tasks.category_id(params[:category_id]) if params[:category_id].present?
  if params[:owner].present?
    case params[:owner]
    when "Vidhya"
      @current_view = "Vidhya's Tasks" 
    when "Param"
      @current_view = "Param's Tasks" 
    when "Shravan"
      @current_view = "Shravan's Tasks" 
    else
      @current_view = "All Tasks" 
    end
  end
  end


  def show
    @task_id = params[:id].split('-').first or not_found
    @task = Task.find(@task_id) or not_found

  end

  def update
    @task = Task.find(params[:id])
    #if @task.update_attributes(:name => "New") 
    if @task.update_attributes(user_params)
      flash[:success] = "Task <strong>'#{@task.title}'</strong> is Updated."
      redirect_to task_path
    else
      render "edit"
    end
  end

  def toggletaskstatus
    @task = Task.find(params[:id]) or not_found
    @task.status == 1 ? @task.status=0 : @task.status=1
    @task.status == 1 ? @task_status= " marked COMPLETE." : @task_status= "OPENED"
    @task.save
    flash[:success] = "Task <strong>'#{@task.title}'</strong> is " + " #{@task_status}"
    redirect_to tasks_path
  end

  def destroy
    @task = Task.find(params[:id]) or not_found
    @task.destroy
    flash[:danger] = "Task <strong>'#{@task.title}'</strong> is deleted."
    redirect_to tasks_path
  end

  def user_params
    params.require(:task).permit(:title,:remarks,:category_id,:due_date,:owner,:priority,:status)
  end

end
