# This file is used to send emails to the user
class UserMailer < ApplicationMailer
  default from: 'test.adresse.beaubourg@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
