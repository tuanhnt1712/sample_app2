class UserMailer < ApplicationMailer
  def account_activation
    @user = user
    mail to: user.email, subject: "Account Activation" #hui den dia chi email cung voi tieu de
  end

  def password_reset #lam o chap 12
    @greeting = "Hi"

    mail to: user.email
  end
end
