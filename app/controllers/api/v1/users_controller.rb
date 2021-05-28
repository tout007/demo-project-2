class Api::V1::UsersController < Api::V1::BaseController
require 'securerandom'

  
  before_action :find_user, only:[:destroy, :show, :update] 
  before_action :admin?, only:[:index, :destroy]
  before_action :authenticate, only: [:update, :show, :destroy]
  
  # Get/users
  def index
    @users = User.all
    render json: @users, status: 200
  end

  # GET user by id
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  # POST create new user
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 200
    else
      render error: {error: 'Unble to create user'}, status: 400
    end
  end 
  
  # PUT update user
  def update
    if @user
      @user.update(user_params)
      render json: {message: 'Successfully updated'}, status: 200
    else
      render json: {error: 'Unble to update user'}, status: 400
    end
  end

  # DELETE: delete user 
  def destroy
    if @user
      @user.destroy
      render json: {message: 'Successfully deleted'}, status: 200
    else
      render json: {error: 'Unble to destroy user'}
    end
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :email, :password, :active, :gender, :city, :block, :role, :image)
    end
end
