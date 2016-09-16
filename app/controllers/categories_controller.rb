class CategoriesController < ApplicationController

  before_action :authenticate_user, :except => [:index , :show ]
  before_action :save_login_state

  helper_method :gettasks_count 

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(user_params)
    if @category.save
      flash[:success] =  "New category <strong>'#{@category.name}'</strong> is created successfully."
      redirect_to categories_path
    else
      render "new"
    end
  end


  def edit
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all
    @current_user = User.find_by_id(session[:current_user_id])

    
  end

  def gettasks_count(cid)
    #@taskCount = Category.includes(:tasks).count
    return Task.category_id(cid).count
  end

  def show
    @category = Category.find(params[:id])
    @taskCount = gettasks_count(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    #if @category.update_attributes(:name => "New") 
    if @category.update_attributes(user_params)
      flash[:success] = "Your category <strong>'#{@category.name}'</strong> is Updated."
      redirect_to category_path
    else
      render "edit"
    end

  end

  def destroy
    @category = Category.find(params[:id])
    if gettasks_count(params[:id]) > 0
          taskCount = gettasks_count(params[:id])
          flash[:danger] = "Category <strong>'#{@category.name}'</strong> cannot be deleted. It has tasks. You must move the tasks to other category first."
          redirect_to categories_path
    else
      @category.destroy
      flash[:success] = "Category <strong>'#{@category.name}'</strong> is just deleted."
      redirect_to categories_path
    end
  end

  def user_params
    params.require(:category).permit(:name,:desc)
  end

end
