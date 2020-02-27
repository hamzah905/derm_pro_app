class AddImageToQuerySpot < ActiveRecord::Migration[5.2]
  def change
    add_column :query_spots, :images, :string, array: true, default: []
  end
end
