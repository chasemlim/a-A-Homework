class UserMailer < ApplicationMailer
  default from: 'everybody@appacademy.io'

  def welcome_email(user)
    @user = user
    @url = 'http://crazycats.com/login'
    mail(to: user.email, subject: 'Thanks for signing up for Crazy Cat Facts!')
  end
end
