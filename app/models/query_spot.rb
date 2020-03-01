class QuerySpot < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy

  mount_uploaders :images, AvatarUploader

    def query_spot_obj
      query_spot_image = []
      images = self.images.present? ? self.images.count.times{ |index|  query_spot_image << self.images[index].url } : ""
      self.attributes.merge(images: query_spot_image.present? ? query_spot_image : "").except("updated_at")
    end
end
