class CategoriesController < ApplicationController
  before_action :check_exist, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "Category created successfully"
      redirect_to categories_url
    else
      flash[:info] = "Something errors"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = "Category updated"
      redirect_to categories_url
    else
      flash[:info] = "Something errors"
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category deleted"
    redirect_to categories_url
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def check_exist
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:info] = "This category does not exist"
      redirect_to root_url
    else
      @category
    end
  end
end
