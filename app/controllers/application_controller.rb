class ApplicationController < ActionController::Base
  
  include Pagy::Backend
  protect_from_forgery
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pagy::OverflowError, with: :redirect_to_last_page
  
  # stop redirect user to welcome_home page if user is admin
  def user_admin?
    unless current_user.present? && current_user.admin?
      redirect_to home_welcome_path and return
    end    
  end

  def after_sign_in_path_for(resource)
    (resource.role == 'user' ? home_welcome_path : admins_home_path)
  end
  
  def show_pop_up
    respond_to do |format|
      format.html
      format.js
    end    
  end
    
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :gender, :city)}
    end
  
  private
    def redirect_to_last_page(exception)
      redirect_to url_for(page: exception.pagy.last), notice: "Page ##{params[:page]} is overflowing. Showing page #{exception.pagy.last} instead."
    end

end
