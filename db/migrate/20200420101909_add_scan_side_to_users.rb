class AddScanSideToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :query_spots, :scan_side, :string
  end
end
