require 'securerandom'
class Api::V1::UsersController < Api::V1::BaseController

  #Get/users
  def index
    @users = User.all
    render json: @users
  end

  #GET user by id
  def show
    @user = User.find(params[:id])
    render json: @user
  end
  
  #POST
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render error: {error: 'Unble to create User'}, status: 400
    end
  end 
  
  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: {message: ' Successfully updated'}, status: 200
    else
      render json: {error: 'Failed'}, status: 400
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :active, :gender, :city, :block)
    end
end
