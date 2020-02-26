class Article < ApplicationRecord
  belongs_to :topic

  # serialize :images
  mount_uploaders :images, AvatarUploader


  def article_obj
    article_images = []
    images = self.images.present? ? self.images.count.times{ |index|  article_images << self.images[index].url } : "" 
    return self.attributes.merge(images: article_images).except("updated_at")
  end
end
