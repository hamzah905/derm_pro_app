class User < ApplicationRecord
	# encrypt password
  has_secure_password :validations => false
  # Model associations

  # Validations
  # validates_presence_of :email
  enum role: [:patient, :doctor]
  validates :email, uniqueness: true

  def is_social?
    self.SocialLogIn.eql? true
  end

  after_initialize do
    if self.new_record?
      self.role ||= :patient
    end
  end
end