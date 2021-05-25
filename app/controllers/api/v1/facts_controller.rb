class Api::V1::FactsController < ApplicationController
  
  before_action :find_fact, only: [:show, :update, :destroy]

  #Get/users
  def index
    @facts = Fact.all
    render json: @facts, status: 200
  end

  #GET user by id
  def show
    @fact = Fact.find(params[:id])
    render json: @fact
  end
  
  #POST
  def create
    @fact = Fact.new(fact_params)
    if @fact.save
      render json: @fact
    else
      render error: {error: 'Unble to create Fact'}, status: 400
    end
  end 
  
  def update
    @fact = Fact.find(params[:id])
    if @fact
      @fact.update(fact_params)
      render json: {message: ' Successfully updated'}, status: 200
    else
      render json: {error: 'Failed'}, status: 400
    end
  end

  private
    def find_find
      @fact = Fact.find(params[:id])  
    end

    def fact_params
      params.require(:fact).permit(:fact, :likes, :user_id)
    end

end

