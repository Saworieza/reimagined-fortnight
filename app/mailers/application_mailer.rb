class ApplicationMailer < ActionMailer::Base
  # default from: 'from@example.com'
  # layout 'mailer'

  def welcome_email(user)
  	@user = user
  	mail to: user.email, subject: "Welcome to Matatu Galore", from: "noreply@matatugalore.com"
  end
end
