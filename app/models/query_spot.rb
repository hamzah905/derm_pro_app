class QuerySpot < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy

  mount_uploaders :images, AvatarUploader

  def query_spot_obj
    query_spot_image = []
    images = self.images.present? ? self.images.count.times{ |index|  query_spot_image << self.images[index].url } : ""
    self.attributes.merge(images: query_spot_image.present? ? query_spot_image : "", created_at: self.created_at.strftime("%d-%b-%Y %H:%M")).except("updated_at")
  end

  def display_name
    "Query Spot " + id.to_s # or that code will return a representation of your Model instance
  end
end
