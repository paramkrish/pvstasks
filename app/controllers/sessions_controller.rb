class SessionsController < ApplicationController
 
	before_action :authenticate_user, :except => [:index, :login, :login_attempt, :logout]
	before_action :save_login_state, :only => [:index, :login, :login_attempt]

	def home
		#Home Page
		flash.discard
	end

	def profile
		flash.discard
		#Profile Page
	end



	def login
		#Login Form
		flash.discard
	end


	def login_attempt
		authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
		if authorized_user
			if authorized_user.status 
				session[:current_user_id] = authorized_user.id
				session[:current_username] = authorized_user.username	
				session[:expires_at] = Time.current + 24.hours
			
				flash[:success] = "Welcome again, #{authorized_user.username} logged in, status #{authorized_user.status}"
				#authorized_user.update_attributes(:status => 1)
				redirect_back_or root_path || redirect_to(:action => 'home')
			else 	
				flash[:success] = "Welcome for the first time, Dear #{authorized_user.username} ... Status #{authorized_user.status}"
				redirect_to users_change_password_path
			end
			
		else
			flash[:danger] = "Invalid Username or Password, status #{authorized_user.status}"
			render "login"	
		end
	end

	def logout
		flash.discard
		session[:current_user_id] = nil
		#redirect_to :action => 'login'
	end





end