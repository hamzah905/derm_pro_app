class AddImageToFeedback < ActiveRecord::Migration[5.2]
  def change
    add_column :feedbacks, :image, :string
    add_column :feedbacks, :user_id, :integer
    add_column :feedbacks, :user_role, :string
    add_column :feedbacks, :feedback_type, :string
  end
end
