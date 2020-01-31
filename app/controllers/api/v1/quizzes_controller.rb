class Api::V1::QuizzesController < Api::V1::BaseController

  def index
    quizzes = Quiz.all
    json_response(true, "All Quizzes", { quizzes: quizzes })
  end

  private
end
