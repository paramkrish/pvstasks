class UsersController < ApplicationController 

  before_action :authenticate_user, :only => [:change_password ]

  require 'sendgrid-ruby'
  include SendGrid


  def new
    flash.discard
    @user = User.new 
  end

  def create
    
    flash.discard
    
    today = Time.now.to_i.to_s
    random_customer_id = ( [*('A'..'Z'),*('1'..'9')]-%w(0 1 I O)).sample(6).join
    @user = User.new(user_params)
    @user.pin = 0
    @user.status = 0
    @user.customer_id = random_customer_id+today
    #@user.update_attributes(:customer_id => random_customer_id+today ) 

    # @user.avatar = params[:file]
    #@user.avatar = File.open('somewhere')    
    if @user.save
      flash[:success] = "You signed up successfully. Please look for the email from us for the next steps."

      email = SendGrid::Mail.new
      email.from = SendGrid::Email.new(email: 'hello@brakko.com', name: "Brakko")

      per = SendGrid::Personalization.new
      per.to = SendGrid::Email.new(email: @user.email)
      per.substitutions = SendGrid::Substitution.new(key: "%username%", value: @user.username)
      per.substitutions = SendGrid::Substitution.new(key: "%button_url%", value: Rails.application.config.web_url + "/login")
      email.personalizations = per
      email.template_id = "c4641b7e-ba2c-4d7f-a5b1-751eebc46be0"

        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: email.to_json)

        puts response.status_code
        puts response.body
        puts response.headers

      redirect_to users_new_path
    else
      render 'new'
    end
    
  end


  def edit
    if ( session[:current_user_id] )
      @current_user = User.find(session[:current_user_id])
    else 
      redirect_to sessions_login_path
    end

  end

  def update
    @current_user = User.find(session[:current_user_id])
    #if @task.update_attributes(:name => "New") 

    if ( ! params[:user][:oldpassword] )

        if @current_user.update_attributes(user_params)

          flash[:success] = "Profile Updated successfully"
          redirect_to sessions_profile_path
        else
          render "edit"
        end

    else 
      authorized_user = User.authenticate(session[:current_username],params[:user][:oldpassword])
         if authorized_user
            if @current_user.update_attributes(user_params)
              flash[:success] = "Password Changed successfully "
              @current_user.update_attributes(:status => 1) 
              redirect_to sessions_profile_path
            else 
              flash[:danger] = "Error in changing the Password. Retry."
              render "change_password"
            end
          else 
            flash[:danger] = "Password verification error. Old Password not matching. "
            render "change_password"
          end
    end
  end


   def change_password
    flash.discard
    @current_user = User.find(session[:current_user_id])   

   end

  def user_params
      params.require(:user).permit(:username,:customer_id, :email, :password, :password_confirmation,:gender,:avatar, :avatar_cache, :firstname, :lastname, :mobile, :address, :city, :pin, :country)
  end


  def session_clear
    session.clear
    @_request.reset_session
    render :text => "session cleared"
  end

end