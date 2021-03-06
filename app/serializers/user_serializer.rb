class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :dob, :contact_no, :role, :gender, :confirmation_code, :email_verified, :avatar, :user_quizes, :number_verified, :all_quizes, :is_activated, :doctor_type, :created_at

  def email_verified
    object.confirmed_at.present? ? true : false
  end

  def avatar
    object.avatar.url
  end

  def all_quizes
    Quiz.pluck(:id)
  end

  def user_quizes
    object.user_quizzes.collect{|user_quiz| user_quiz.user_quiz_obj }
  end
end