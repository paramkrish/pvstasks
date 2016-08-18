class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(user_params)
    if @category.save
      flash[:success] =  "New category created"
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

  def show
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    #if @category.update_attributes(:name => "New") 
    if @category.update_attributes(user_params)
      flash[:success] = "Your category is Updated."
      redirect_to category_path
    else
      render "edit"
    end

  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:danger] = "That category is deleted."
    redirect_to categories_path
  end

  def user_params
    params.require(:category).permit(:name)
  end

end
