class AddMessageToTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :tickets, :message, :string
    add_column :tickets, :description, :string
  end
end
