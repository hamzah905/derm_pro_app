class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :quiz_id

      t.timestamps
    end
  end
end
