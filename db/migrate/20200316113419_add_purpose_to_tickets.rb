class AddPurposeToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :purpose, :string
  end
end
