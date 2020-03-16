class AddQuerySpotPlaceToFeedbacks < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :query_spot_place, :string
  end
end
