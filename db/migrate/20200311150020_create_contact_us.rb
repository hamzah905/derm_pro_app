class CreateContactUs < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_us do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
