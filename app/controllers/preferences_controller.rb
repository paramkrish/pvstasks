class PreferencesController < ApplicationController

  before_action :authenticate_user
  before_action :save_login_state

  def index
  	  @preferences = Preference.where(:user_id => session[:current_user_id]).first
  end

  def edit
  end

  def update
    @p = Preference.find(params[:id])
    #if @task.update_attributes(:name => "New") 
    if @p.update_attributes(pref_params)
    	flash[:success] = "Preferences Updated"
    	redirect_to preferences_path
    end

  end

    def pref_params
    params.require(:preference).permit(:notifyfor_newtask,:notifyfor_taskupdate, :notifyfor_taskcomplete, :notifyfor_comment2task)
  	end

end
