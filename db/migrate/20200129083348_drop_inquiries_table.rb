class DropInquiriesTable < ActiveRecord::Migration[5.2]
  def up
    drop_table :inquiries
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
