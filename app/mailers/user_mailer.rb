class UserMailer < ApplicationMailer
default from: 'notifications@example.com'

  def send_welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: 'jonasa@sourcepad.com', subject: 'Welcome to My Awesome Site')
  end

  def send_reset_password_email(user)
    @user = user
    @change_password_link = "#{domain}/reset-password?t=#{user.reset_password_token}"
    mail(to: 'jonasa@sourcepad.com', subject: 'Reset Password')
  end
end
