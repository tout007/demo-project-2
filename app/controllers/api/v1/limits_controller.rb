class Api::V1::LimitsController < Api::V1::BaseController
  
  before_action :find_limit, only:[:show, :update, :destroy]
  before_action :authenticate

  def index
    @limit = current_user.limit
    render json: @limit
  end

  def show
    render json: @limit
  end

  def create
    @limit = current_user.limit.new(limit_params)
    if @limit.save
      render json: @limit 
    else
      render error: {error: 'Failed to add limit'}, status: 400
    end
  end

  def update
    if @limit
      @limit.update(limit_params)
      render json: @limit
    else
      render error: {error: 'Failed to update limit'}, status: 400
    end
  end

  def destroy
    if @limit
      @limit.destroy
      render json: @limit
    else
      render error: {error: 'Failed to destroy limit'}, status: 400
    end
  end

  private
    def find_limit
      @limit = Limit.find(params[:id])
    end

    def limit_params
      params.permit(:monthly_limit, :month_at, :user_id, :daily_limit)
    end
end