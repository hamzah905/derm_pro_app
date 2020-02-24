class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz

  def user_quiz_obj
    return self.attributes.merge(quiz_name: self.quiz.title).except("user_id", "quiz_id", "updated_at")
  end
end
