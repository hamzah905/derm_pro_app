class User < ApplicationRecord
	# encrypt password
  # has_secure_password
  # Model associations

  # Validations
  # validates_presence_of :email
  validates :email, uniqueness: true

  def is_social?
    self.SocialLogIn.eql? true
  end
end