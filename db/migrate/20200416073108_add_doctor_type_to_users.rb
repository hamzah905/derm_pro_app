class AddDoctorTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :doctor_type, :integer
  end
end
