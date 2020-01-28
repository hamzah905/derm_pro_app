class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :gender, :string
  	add_column :users, :dob, :string
  	add_column :users, :height, :string
  	add_column :users, :martial_status, :string
  	add_column :users, :education, :string
  	add_column :users, :religious_education, :string
  	add_column :users, :cast, :string
  	add_column :users, :school_of_thoughts, :string
  	add_column :users, :brothers, :string
  	add_column :users, :sisters, :string
  	add_column :users, :father_occupation, :string
  	add_column :users, :occupation, :string
  	add_column :users, :monthly_income, :string
  	add_column :users, :residence, :string
  	add_column :users, :city, :string
  	add_column :users, :contact_no, :string
  	add_column :users, :requirement, :text
  	add_column :users, :account_status, :boolean, default: false
  end
end
