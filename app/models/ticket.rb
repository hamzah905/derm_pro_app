class Ticket < ApplicationRecord
  has_many :inquiries, dependent: :destroy
  belongs_to :user

  mount_uploader :image, AvatarUploader
end
