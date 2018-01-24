ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'matweet.herokuapp.com',
  user_name:            ENV["ojey29"],
  password:             ENV["incorrect1"],
  authentication:       'plain',
  enable_starttls_auto: true 
}