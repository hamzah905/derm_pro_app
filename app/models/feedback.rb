class Feedback < ApplicationRecord
  belongs_to :query_spot
  belongs_to :user, optional: true

  mount_uploader :image, AvatarUploader


  def feedback_obj
    self.attributes.merge(image: self.image.url)
  end
end
