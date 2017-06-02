class UserMailer < ApplicationMailer
  def account_activation
    @user = user
    mail to: user.email, subject: "Account Activation" #hui den dia chi email cung voi tieu de
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
