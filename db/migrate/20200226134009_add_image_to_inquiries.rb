class AddImageToInquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :images, :string, array: true, default: []
  end
end
