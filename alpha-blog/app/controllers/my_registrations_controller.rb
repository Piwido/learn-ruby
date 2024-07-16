# Useful to override the default Devise::RegistrationsController
class MyRegistrationsController < Devise::RegistrationsController
  def create
    super
    UserMailer.with(user: @user).welcome_email.deliver_now
    flash[:notice] = "Email de bienvenue envoyé avec succès à #{@user.email}!"
  end
end
