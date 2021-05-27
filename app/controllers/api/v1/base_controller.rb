class Api::V1::BaseController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  before_action :authenticate
   
  # before_filter :verify_authenticity_token, only: [:create, :index]

  protected
    def authenticate
      # token authticate
      user = User.find_by(token: request.env['HTTP_AUTHENTICATE_TOKEN'])
      if user.present?
        sign_in(user)
      else  
        return render json: {}, status: 401
      end
    end

    def admin?
      unless current_user.present? && current_user.admin?
        return render json: {error: "UnAuthorized User"}, status: 401 
      end    
  end
end