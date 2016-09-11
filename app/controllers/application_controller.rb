class ApplicationController < ActionController::Base
  protect_from_forgery
  protected

  def authenticate_user
    if ! session[:current_user_id]
        store_location  
        flash[:danger]  = "Your Login is failed"
        redirect_to(:controller => 'sessions', :action => 'login')
        return false

    elsif session[:expires_at] < Time.current 

          flash[:danger]  = "Your session is expired, Please login again "
          redirect_to(:controller => 'sessions', :action => 'login')
          return false
      
    else      
          @current_user = User.find session[:current_user_id] 
          return true
    end

  end



  # def authenticate_user1
  # 	unless session[:current_user_id]  or session[:expires_at] > Time.current
  # 		store_location	
  #     flash[:danger]	= "Your session is expired or Login failed"
  # 		redirect_to(:controller => 'sessions', :action => 'login')
  # 		return false
  # 	else
  #     # set current_user by the current user object
  #     @current_user = User.find session[:current_user_id] 
  #     #session[:expires_at] = Time.current + 5.minutes
  # 		return true
  # 	end
  # end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:current_user_id]
           # redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end


	  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end



end