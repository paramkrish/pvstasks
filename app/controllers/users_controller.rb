class UsersController < ApplicationController 


  def new
    flash.discard
    @user = User.new 
  end

  def create
    
    flash.discard
    
    today = Time.now.to_i.to_s
    random_customer_id = ( [*('A'..'Z'),*('1'..'9')]-%w(0 1 I O)).sample(6).join
    @user = User.new(user_params)
    @user.customer_id = random_customer_id+today
    #@user.update_attributes(:customer_id => random_customer_id+today ) 

    # @user.avatar = params[:file]
    #@user.avatar = File.open('somewhere')    
    if @user.save
      flash[:success] = "You signed up successfully"
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
    if @current_user.update_attributes(user_params)

      flash[:success] = "Profile Updated"
      redirect_to sessions_profile_path
    else
      render "edit"
    end
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