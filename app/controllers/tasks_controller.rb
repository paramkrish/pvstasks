class TasksController < ApplicationController
  require 'sendgrid-ruby'
  include SendGrid

  before_action :authenticate_user, :except => [:index , :show ]
  before_action :save_login_state

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

      from = Email.new(email: 'Brakki Support <donot_reply@brakki.com>')
      subject = "New Task '#{@task.title}' is created successfully by "+session[:current_username]+' !'
      to = Email.new(email: 'mkparam@gmail.com')
      content = Content.new(type: 'text/plain', value: 'Hello !!')
      mail = Mail.new(from, subject, to, content)

      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      puts response.status_code
      puts response.body
      puts response.headers

      redirect_to tasks_path
    else
      render "new"
    end
  end


  def edit
    @task = Task.find(params[:id])
  end

  def index
  flash.discard

  @current_view = "All Tasks"

  @current_user = User.find_by_id(session[:current_user_id])
  @tasks = Task.where(nil) # creates an anonymous scope
  @tasks = @tasks.status(params[:status]) if params[:status].present?
  @tasks = @tasks.user_id(params[:user_id]) if params[:user_id].present?
  @tasks = @tasks.priority(params[:priority]) if params[:priority].present?
  if params[:status].present?
    params[:status] == "0" ? @current_view = "Open Tasks" : @current_view = "Closed Tasks"
  end
  #@tasks = @tasks.category_id(params[:category_id]) if params[:category_id].present?
    if params[:user_id].present?
      @current_view = "My Tasks" 
    else
      @current_view = "All Tasks" 
    end
  end

  def show
    @task_id = params[:id].split('-').first or not_found
    @task = Task.find(@task_id) or not_found    
    @task.update_attributes("numviews" => @task.numviews+1)
    if (session[:current_user_id])
     @current_user = User.find(session[:current_user_id])
    end


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
    @task.status == 1 ? @task_status= " marked COMPLETE." : @task_status= "RE-OPENED"
    @task.save
        flash[:success] = "Task <strong>'#{@task.title}'</strong> is " + " #{@task_status}"
    redirect_to tasks_path
  end


  def comment_add_to_tasks
    flash[:success] = "Comment added"
  end

  def destroy
    @task = Task.find(params[:id]) or not_found
    @task.destroy
    flash[:danger] = "Task <strong>'#{@task.title}'</strong> is deleted."
    redirect_to tasks_path
  end

  def user_params
    params.require(:task).permit(:title,:remarks,:category_id,:user_id,:due_date,:priority,:status)
  end

end
