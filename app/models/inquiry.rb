class Inquiry < ApplicationRecord
  belongs_to :user

  mount_uploaders :images, AvatarUploader
end
