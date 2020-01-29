class RemoveNameFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :name, :string
    remove_column :users, :height, :string
    remove_column :users, :martial_status, :string
    remove_column :users, :education, :string
    remove_column :users, :religious_education, :string
    remove_column :users, :cast, :string
    remove_column :users, :school_of_thoughts, :string
    remove_column :users, :brothers, :string
    remove_column :users, :sisters, :string
    remove_column :users, :father_occupation, :string
    remove_column :users, :occupation, :string
    remove_column :users, :monthly_income, :string
    remove_column :users, :residence, :string
    remove_column :users, :city, :string
    remove_column :users, :requirement, :text
    rename_column :users, :registered, :is_activated
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
