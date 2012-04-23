class UserMailer < ActionMailer::Base
  #default from: "from@example.com"
  # TODO: this ^

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail = Mail.new do 
	from: "from@example.com"
	to: user.email
	subject: "Password Reset"
	body: "Your new password is here"
	end
    mail.to_s
  end
end
