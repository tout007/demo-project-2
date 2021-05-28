class Api::V1::AuthenticationController < Api::V1::BaseController
  
  skip_before_action :authenticate_request

  def authenticate
  
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def signup
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 200
    else
      render error: {error: 'Unble to create user'}, status: 400
    end
  end

  private
    def user_params
      params.permit(:name, :email, :password, :active, :gender, :city, :block, :role, :image)
    end
end