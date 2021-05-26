class UsersController < ApplicationController

  before_action :set_user, only: %i[ show edit block]

  after_action :after_signup, only: [:create]
  
  before_action :check_signed_in, only: [:signup]
  
  def index
    @pagy, @users = pagy(User.all,  items: 2)
  end

  def edit_profile
  end

  def update_profile
    if current_user.update(update_user_params)
      redirect_to edit_profile_users_path,
      alert: 'Profile updated successfully'
    else
      render :edit_profile
    end
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_welcome_path,
      notice: "User created successfully"
    else 
      flash.now[:alert] = 'Somthing went wrong'
      render "signup"
    end
  end

  def logout   
    session[:user_id] = nil 
    flash[:success] = "You have logged out"  
    redirect_to login_path, notice: "Logged out"
  end  

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
    flash[:alert] = "Deleted successfully!!"
  end

  def block
    @user.toggle(:block)
    if @user.save
      redirect_to users_path 
    end
  end 

  private
    def check_signed_in
      if session[:user_id].present?
        redirect_to home_welcome_path and return
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :active, :gender, :city, :block)
    end
    
    def update_user_params
      params.require(:user).permit(:name, :gender, :city, :image)
    end

    def after_signup
      if session[:user_id].present?
        return
      end
    end
    
end
