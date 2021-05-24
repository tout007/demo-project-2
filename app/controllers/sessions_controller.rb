class SessionsController < ApplicationController
  before_action :check_signed_in
 
  def login
  end

  def create
    @user = User.find_by_email(params[:session][:email])   
  
    if @user && @user.authenticate(params[:session][:password])  
      session[:user_id] = @user.id   
      if @user.role == 'admin'
        redirect_to admins_home_path, notice: 'Successfully Logged in!' 
      else
        redirect_to home_welcome_path, notice: 'Successfully Logged in!'   #
      end
    else   
      flash.now[:alert] = 'Invalid email/password combination'
      render :login   
    end   
  end   

  def destroy 
    User.find(session[:user_id]).destroy
    session[:user_id] = nil 
    flash[:success] = "You have logged out"  
    redirect_to login_path, notice: "Logged out"
  end   

  private
    def check_signed_in
      if session[:user_id].present?
        redirect_to home_welcome_path and return
      end
    end
end
