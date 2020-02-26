class Article < ApplicationRecord
  belongs_to :topic

  # serialize :images
  mount_uploaders :images, AvatarUploader
end
