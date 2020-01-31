class Answer < ApplicationRecord
  belongs_to :question

  validate :validate_correct_uniqueness

  def validate_correct_uniqueness
    errors.add(:correct, "This question already have the correct answer.") if (self.correct == true) && Answer.where(correct: true, question_id: self.question_id).any?
  end
end
