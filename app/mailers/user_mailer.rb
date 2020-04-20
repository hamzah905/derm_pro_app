class UserMailer < ApplicationMailer
	default from: 'info@dermpro.com'
 
  def password_email
    @email = params[:email]
    @password = params[:key]
    @url  = 'http://example.com/login'
    mail(to: @email, subject: 'Reset Password Instructions')
  end

  def confirmation_email
    @email = params[:email]
    @code = params[:code]
    @url  = 'http://example.com/login'
    mail(to: @email, subject: 'Account Confirmation Instructions')
  end
end


