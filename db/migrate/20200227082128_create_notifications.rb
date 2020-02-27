class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :thumbnail_url
      t.string :notification_type
      t.string :thumbnail_url
      t.datetime :notification_time

      t.timestamps
    end
  end
end
