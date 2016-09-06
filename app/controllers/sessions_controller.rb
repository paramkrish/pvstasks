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

	def setting
		#Setting Page
		flash.discard
	end

	def login
		#Login Form
		flash.discard
	end


	def login_attempt
		authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
		if authorized_user
			session[:user_id] = authorized_user.id
			session[:username] = authorized_user.username
			flash[:success] = "Welcome again, #{authorized_user.username} logged in"
			redirect_back_or root_path || redirect_to(:action => 'home')


		else
			flash[:danger] = "Invalid Username or Password"
			render "login"	
		end
	end

	def logout
		flash.discard
		session[:user_id] = nil
		#redirect_to :action => 'login'
	end




end