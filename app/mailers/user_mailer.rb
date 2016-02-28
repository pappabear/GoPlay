class UserMailer < ApplicationMailer


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end


  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end


  def email_hq_about_new_user(user)
    @user = user
    mail to: 'chip.irek@gmail.com', subject: "New user: " + @user.name
  end


end
