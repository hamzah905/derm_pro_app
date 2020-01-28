class AddregisteredToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :registered, :boolean, default: false
  end
end
