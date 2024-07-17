# Useful to override the default Devise::RegistrationsController
class MyRegistrationsController < Devise::RegistrationsController
  def create
    super
    return unless @user.persisted?

    UserMailer.with(user: @user).welcome_email.deliver_now
    flash[:notice] = "Email de bienvenue désactivé : #{@user.email}!"
  end
end
