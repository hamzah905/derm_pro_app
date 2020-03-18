class Reminder < ApplicationRecord
  include ApplicationHelper
  belongs_to :user
  before_save :send_notification_reminder

  validates :title, uniqueness: true
  validates :description, uniqueness: true

  def send_notification_reminder
    registration_id = self.user.fcm_token
    puts "starttttttt"
    send_notification(registration_id, self.title, self.description, "reminder", self.user_id, nil)
    puts "endddddd"
  end
end
