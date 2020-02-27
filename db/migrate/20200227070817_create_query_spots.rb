class CreateQuerySpots < ActiveRecord::Migration[5.2]
  def change
    create_table :query_spots do |t|
      t.string :message

      t.timestamps
    end
  end
end
