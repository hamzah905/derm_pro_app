class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.Unable_to_Update
    'Unable to Update'
  end

  def self.updated
    'Updated'
  end

  def self.Unable_to_process
    'Unable to process'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.user_not_found
    'User not found'
  end

  def self.password_sent
    'Password sent to email'
  end

  def self.password_changed
    'Password has been changed'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.already_exists
    'Account already exists for this email'
  end

  def self.inquiry_created
    'Inquiry Created Successfully'
  end

  def self.unable_to_create_inquiry
    'Error, Unable to Create Inquiry'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.LoggedIn
    'You have successfully Logged In.'
  end
end