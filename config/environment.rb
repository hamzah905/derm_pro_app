# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#Gmail Conf for sending emails
ActionMailer::Base.perform_deliveries = true 
ActionMailer::Base.default_url_options = { host: 'https://admin.dermpro.com.au/'}
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :user_name => 'hamzazubair',
  :password => 'H@mza3210',
  :domain => 'sendgrid.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}