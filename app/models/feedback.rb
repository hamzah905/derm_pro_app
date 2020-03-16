class Feedback < ApplicationRecord
  belongs_to :query_spot
  belongs_to :user, optional: true

  mount_uploader :image, AvatarUploader


  def feedback_obj
    self.attributes.merge(image: self.image.url, user_name: self.user.present? ? self.user.email : "")
  end

  def display_name
    "Communication " + id.to_s # or that code will return a representation of your Model instance
  end
end
