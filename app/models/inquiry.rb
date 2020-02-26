class Inquiry < ApplicationRecord
  belongs_to :ticket

  mount_uploaders :images, AvatarUploader

    def inquiry_obj
      inquiry_image = []
      images = self.images.present? ? self.images.count.times{ |index|  inquiry_image << self.images[index].url } : ""
      self.attributes.merge(images: inquiry_image.present? ? inquiry_image : "").except("updated_at")
    end
end
