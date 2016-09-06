class UsersController < ApplicationController 


  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You signed up successfully"
      redirect_to users_new_path
    else
      render 'new'
    end
    

  end

  def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end


end