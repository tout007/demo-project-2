class Api::V1::BaseController < ApplicationController
  
  respond_to :json
  
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request
  attr_reader :current_user

  # skip_before_action :authenticate_user!, :only => "reply", :raise => false

  # before_action :authenticate
   
  # protected
  #   def authenticate
  #     # token authticate
  #     user = User.find_by(token: request.env['HTTP_AUTHENTICATE_TOKEN'])
  #     if user.present?
  #       sign_in(user)
  #     else  
  #       return render json: {}, status: 401
  #     end
  #   end

  private
    def authenticate_request
      @current_user = ::AuthorizeApiRequest.call(request.headers).result
      render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end  

    def admin?
      unless current_user.present? && current_user.admin?
        return render json: {error: "UnAuthorized User"}, status: 401 
      end    
    end

end