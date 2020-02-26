class RemoveUserFromInquiries < ActiveRecord::Migration[5.2]
  def change
    remove_column :inquiries, :user_id, :integer
    add_column :inquiries, :ticket_id, :integer
  end
end
