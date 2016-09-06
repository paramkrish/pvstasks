class ApplicationController < ActionController::Base
  protect_from_forgery
  protected

  def authenticate_user
  	unless session[:user_id]  
  		store_location		
  		redirect_to(:controller => 'sessions', :action => 'login')
  		return false
  	else
      # set current_user by the current user object
      @current_user = User.find session[:user_id] 
  		return true
  	end
  end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
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