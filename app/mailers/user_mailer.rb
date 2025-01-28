class UserMailer < ApplicationMailer
    def confirmation_email(user)
      @user = user
      mail(to: @user.email, subject: "Welcome Email")
    end
end
