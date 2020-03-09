class AddQuerSpotPlaceToQuerySpots < ActiveRecord::Migration[5.2]
  def change
    add_column :query_spots, :quer_spot_place, :string
  end
end
