class User < ApplicationRecord
	# encrypt password
  has_secure_password :validations => false
  # validates_confirmation_of :password

  # Model associations
  has_many :user_quizzes
  has_many :query_spots, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :quizzes, through: :user_quizzes

  devise :registerable, :confirmable, :validatable

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

  def display_name
    email # or that code will return a representation of your Model instance
  end
end