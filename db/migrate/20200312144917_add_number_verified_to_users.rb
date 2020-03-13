class AddNumberVerifiedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :number_verified, :boolean, default: false
  end
end
