class AddUserIdToQuerySpots < ActiveRecord::Migration[5.2]
  def change
    add_column :query_spots, :user_id, :integer
  end
end
