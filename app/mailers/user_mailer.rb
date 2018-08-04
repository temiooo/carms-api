class UserMailer < ApplicationMailer
  def reset_password_email(user)
    @user = user

    mail(to: @user.email, subject: 'CARMS Password Reset')
  end
end
