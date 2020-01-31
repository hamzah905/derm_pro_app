class Question < ApplicationRecord
  # has_many :question_options, dependent: :destroy
  # has_many :answers, through: :question_options
  belongs_to :quiz
  has_many :answers, dependent: :destroy


  def display_name
    question # or that code will return a representation of your Model instance
  end
end
