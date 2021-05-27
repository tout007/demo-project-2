class Api::V1::CategoriesController < Api::V1::BaseController
  
  before_action :admin?
  before_action :find_category, only:[:show, :update, :destroy]
  before_action :authenticate

  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category 
    else
      render error: {error: 'Failed to add category'}, status: 400
    end
  end

  def update
    if @category
      @category.update(category_params)
      render json: @category
    else
      render error: {error: 'Failed to update category'}, status: 400
    end
  end

  def destroy
    if @category
      @category.destroy
      render json: @category
    else
      render error: {error: 'Failed to destroy category'}, status: 400
    end
  end

  private
    def find_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.permit(:name)
    end
   
end