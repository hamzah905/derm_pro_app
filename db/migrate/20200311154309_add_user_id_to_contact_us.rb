class AddUserIdToContactUs < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_us, :user_id, :integer
  end
end
