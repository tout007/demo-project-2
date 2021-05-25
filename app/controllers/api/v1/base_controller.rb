class Api::V1::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :authenticate
 
  protected
    def authenticate
      # token authticate
      user = User.find_by(token: request.env['HTTP_AUTHTICATE_TOKEN'])
      if user.present?
        sign_in(user)
      else  
        return render json: {}, status: 401
      end
    end
end