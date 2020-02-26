class AddImageToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :images, :string, array: true, default: []
  end
end
