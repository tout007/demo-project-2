class CategoriesController < ApplicationController
  before_action :user_admin?
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def add_category
    @category = Category.new
    show_pop_up
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path,
      alert: 'Category updated successfully'
    else
      render :edit
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path,
      notice: "Successfully added"
    end
  end

  def index
    @categories = Category.all
  end

  def destroy
    @category.destroy
    @categories = Category.all
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end

end
