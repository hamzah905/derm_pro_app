class Ticket < ApplicationRecord
  
  has_many :inquiries, dependent: :destroy
  belongs_to :user
end
