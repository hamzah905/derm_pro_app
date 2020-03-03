class AddDiseaseToQuerySpots < ActiveRecord::Migration[5.2]
  def change
    add_column :query_spots, :disease, :string
  end
end
