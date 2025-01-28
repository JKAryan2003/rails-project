class AdminMailer < ApplicationMailer
  def welcome_email(admin)
    # @new_user_path = new_user_path
    @admin = admin
    mail(to: @admin.email, subject: "Welcome Email")
  end
end
