class RenameQuerSpotPlaceInQuerySpots < ActiveRecord::Migration[5.2]
    def change
        remove_column :query_spots, :quer_spot_place, :string
        add_column :query_spots, :query_spot_place, :string
    end
end
