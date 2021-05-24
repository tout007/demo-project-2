class SignupMailer < ApplicationMailer

  def signup_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to My Site')
  end
end
