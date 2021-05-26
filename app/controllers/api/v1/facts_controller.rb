class Api::V1::FactsController < Api::V1::BaseController
  
   before_action :find_fact, only: [:show, :update,:destroy]

  #Get/users
  def index
    @facts = Fact.all
    render json: @facts, status: 200
  end

  #GET fact by id
  def show
    render json: @fact
  end
  
  #POST
  def create
    @fact = Fact.new(fact_params)
    if @fact.save
      render json: @fact
    else
      render error: {error: 'Unble to create fact'}, status: 400
    end
  end 
  
  def update
    if @fact
      @fact.update(fact_params)
      render json: {message: ' Successfully updated'}, status: 200
    else
      render json: {error: 'Unble to update fact'}, status: 400
    end
  end

  def destroy
    if @fact
      @fact.destroy
      render json: {message: 'Successfully deleted'}, status: 200
    else
      render json: {error: 'Unble to destroy fact'}
    end
  end

  private
    def find_fact
      @fact = Fact.find(params[:id])  
    end

    def fact_params
      # params.require(:fact).permit(:likes, :fact, :user_id)
      params.permit(:fact, :likes, :user_id)
    end

end

