class LimitsController < ApplicationController
  before_action :set_limit, only: [:remove, :edit, :update]

  def add_limit
    @limit = Limit.new
    show_pop_up
  end

  def create
    @limit = Limit.new(limit_params)
    @limit.user_id = current_user.id
    if @limit.save
      redirect_to limits_path,
      notice: "Successfully added" 
    else
      flash.now[:alert] = "Invalid input"
      render "add_limit" 
    end
  end

  def edit
  end

  def update
    if @limit.update(limit_params)
      redirect_to limits_path,
      alert: 'Limit updated successfully'
    else
      render :edit
    end
  end

  def index
    @limit = current_user.limit
  end

  def remove
    @limit.destroy
    redirect_to limits_path,
    alert: 'Limit removed successfully'
  end

  private 
    def set_limit
      @limit = Limit.find(params[:id])
    end

    def limit_params
      params.require(:limit).permit(:monthly_limit, :user_id, :month_at)
    end
end
