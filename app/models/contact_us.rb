class ContactUs < ApplicationRecord
  self.table_name = "contact_us"
  belongs_to :user, optional: true
end
