class CategoriesController < ApplicationController

  helper_method :gettasks_count 

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(user_params)
    if @category.save
      flash[:success] =  "New category '#{@category.name}' created"
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
      flash[:success] = "Your category '#{@category.name}' is Updated."
      redirect_to category_path
    else
      render "edit"
    end

  end

  def destroy
    @category = Category.find(params[:id])
    if gettasks_count > 0
          #@taskCount = Task.category_id(@category.id).count
          flash[:danger] = "Category '#{@category.name}' cannot be deleted. It has #{gettasks_count} tasks. Please move them to delete this category."
          redirect_to categories_path
    else
      @category.destroy
      flash[:success] = "Category '#{@category.name}' deleted."
      redirect_to categories_path
    end
  end

  def user_params
    params.require(:category).permit(:name)
  end

end
