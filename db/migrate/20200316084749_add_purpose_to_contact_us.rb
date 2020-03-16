class AddPurposeToContactUs < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_us, :purpose, :string
    add_column :notifications, :obj_id, :integer
    add_column :tickets, :image, :string
  end
end
