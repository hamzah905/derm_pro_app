class Api::V1::UserQuizzesController < Api::V1::BaseController
  
  def create
    quiz = Quiz.find(params[:quiz_id])
    user_quiz = current_user.user_quizzes.create(quiz: quiz)
    answers = (params[:answers].class == Array) ? params[:answers] : JSON.parse(params[:answers])
    answers.each do |answer_hash|
      question_option = QuestionOption.find(answer_hash['question_option_id'])
      answer = question_option.answers.create(user_quiz: user_quiz, question_id: question_option.question_id, correct: question_option.correct)
    end
    json_response(true, "Quiz successfully submitted", {
        quiz: {
            attempt_count: current_user.user_quizzes.where(quiz: quiz, created_at: DateTime.now.all_day).count
        }
    })
  end

  def delete_all
    current_user.user_quizzes.destroy_all
    json_response(true, "All Quizzes Deleted", nil)
  end

end
