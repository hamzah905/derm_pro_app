class AddConfirmationCodeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :confirmation_code, :string
  end
end
