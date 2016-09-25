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
    @task = Task.new(task_params)
    @task.update_attributes(:status =>0, :user_id => session[:current_user_id] ) 


    if @task.save

        @tracking = Tracking.new
        @tracking.update_attributes(:user_id => session[:current_user_id] , :task_id => @task.id, :change => "Created the Task") 
        @tracking.save
        @assigned_to_user = User.where(:id => @task.user_id).first
        task_title = @task.title.html_safe.gsub ' ','-'
        task_title = task_title.sub '-$',''
        task_title_link = Rails.application.config.web_url + "/tasks/" + @task.id.to_s + "/" + task_title
        flash[:success] =  "New Task <strong>'#{@task.title}'</strong> is created successfully "

          email = SendGrid::Mail.new
          email.from = SendGrid::Email.new(email: 'hello@brakko.com', name: "Brakko")

          per = SendGrid::Personalization.new
          per.to = SendGrid::Email.new(email: "mkparam@gmail.com", name: "Param Krish")
          per.substitutions = SendGrid::Substitution.new(key: "%username%", value: session[:current_username])
          per.substitutions = SendGrid::Substitution.new(key: "%taskname%", value:  @task.title )
          per.substitutions = SendGrid::Substitution.new(key: "%assigned_to%", value: @assigned_to_user.username)
          per.substitutions = SendGrid::Substitution.new(key: "%button_url%", value: task_title_link )
          email.personalizations = per
          email.template_id = "dbcbd621-e3ef-4e8a-8fae-d49c63803cb7"

            sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
            response = sg.client.mail._('send').post(request_body: email.to_json)

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
  @tasks = @tasks.assignedto_id(params[:assignedto_id]) if params[:assignedto_id].present?
  @tasks = @tasks.priority(params[:priority]) if params[:priority].present?
  if params[:status].present?
    params[:status] == "0" ? @current_view = "Open Tasks" : @current_view = "Closed Tasks"
  end
  #@tasks = @tasks.category_id(params[:category_id]) if params[:category_id].present?
    if params[:user_id].present?
      @user = User.where(:id=>params[:user_id]).first
      @current_view = "Tasks Created by '" + @user.username + "'"
    elsif params[:assignedto_id].present?
      @user = User.where(:id=>params[:assignedto_id]).first
      @current_view = "Tasks Assigned To '" + @user.username + "'"
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
    if @task.update_attributes(task_params)

        @tracking = Tracking.new
        @tracking.update_attributes(:user_id => session[:current_user_id] , :task_id => @task.id, :change => "Task Updated") 
        @tracking.save

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

        @tracking = Tracking.new
        @tracking.update_attributes(:user_id => session[:current_user_id] , :task_id => @task.id, :change => "Task status changed to " + @task_status) 
        @tracking.save

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

  def tracking
    @tracking = Tracking.where(:task_id=> params[:id]) or not_found
    render json: @tracking
  end

  def tracking_params
    params.require(:tracking).permit(:task_id,:user_id,:change)
  end

  def task_params
      params.require(:task).permit(:title,:remarks, :status, :due_date, :priority,:category_id, :user_id, :assignedto_id)
  end

  
end
