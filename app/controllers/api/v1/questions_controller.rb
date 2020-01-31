class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :get_quiz

  def index
    questions = @quiz.questions.collect{|question| question_obj(question)}
    response = { auth_token: auth_token, questions: questions}
    json_response(response)
  end

  def get_questions
    quiz = Quiz.find(params[:id])
    quiz_questions = quiz.questions
    json_response(true, 200, "Quiz Questions", { questions: quiz_questions })
  end

  private

  def get_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_obj(question)
    question.attributes.merge(id: question.id, question: question.question, correct_option: (question.answers.any? && question.answers.where(correct: true).present?) ? question.answers.where(correct: true).first.id : nil,  options: question.answers.collect{|option| option_obj(option)}).except("created_at", "updated_at", "correct")
  end

  def option_obj(option)
    option.attributes.except("created_at", "updated_at", "question_id")
  end

end
