class User < ApplicationRecord
	# encrypt password
  has_secure_password :validations => false
  # Model associations
  has_many :quizzes, through: :user_quizzes
  has_many :user_quizzes

  devise :registerable, :confirmable

  # Validations
  # validates_presence_of :email
  enum role: [:patient, :doctor]
  validates :email, uniqueness: true

  mount_uploader :avatar, AvatarUploader

  scope :All, -> {order("users.created_at DESC")}
  scope :patients, -> {where(role: "patient")}
  scope :doctors, -> {where(role: "doctor")}

  def is_social?
    self.SocialLogIn.eql? true
  end

  after_initialize do
    if self.new_record?
      self.role ||= :patient
    end
  end
end