class AddRiskToUserQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :user_quizzes, :risk, :string
    add_column :user_quizzes, :skin_type, :string
  end
end
