class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("account_activation")
  end

  def password_reset
    @greeting = t "hi"

    mail to: t("to@example.org")
  end
end
