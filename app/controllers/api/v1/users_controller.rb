class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_request, only: [ :create, :forget_password, :social_login_in, :all_patients, :patient_detail, :search_patients]
  before_action :set_user, only: [:update, :show, :patient_detail]
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.find_by(email: params[:email])
    unless user.present?
      params[:confirmation_code] = rand.to_s[2..5] if params[:contact_no].present?
      params[:is_activated] = true
      user = User.create!(user_params)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, user: ActiveModelSerializers::SerializableResource.new(user), auth_token: auth_token }
      json_response(response, :created)
    else
      response = { message: Message.already_exists, email_already_exist: true }
      json_error_response(response)
    end
  end

  def update
    if @user.present?
      if @user.update(user_params)
        response = { message: Message.updated, user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
        json_response(response)
      else
        response = { message: Message.Unable_to_Update, auth_token: auth_token }
        json_error_response(response)
      end
    else
      response = { message: "Can not find user with id = #{params[:id]}", auth_token: auth_token }
      json_error_response(response)
    end
  end

  def social_login_in
    if params[:uid].present?
      user = User.find_by(uid: params[:uid])
      unless user
        user = User.new(social_params)
        user.password = (User.last.id + 1).to_s
        message = user.save ? Message.account_created : Message.account_not_created
      else
        message = Message.LoggedIn
      end
      auth_token = AuthenticateUser.new(params[:uid], nil).call
      
      response = {message: message, user: ActiveModelSerializers::SerializableResource.new(user), auth_token: auth_token}
      json_response(response)
    else
      raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
      )
    end
  end

  def forget_password
    @user = User.find_by(email: params[:email])
    if @user
      begin
        key = generate_password(@user.id)
        puts @user.update(password: key)
        UserMailer.with(email: @user.email, key: key).password_email.deliver_now
        response = { message: Message.password_sent, status: true}
        json_response(response)
      rescue
        response = { message: Message.Unable_to_process, status: false}
        json_error_response(response)
      end
    else
      response = { message: Message.user_not_found, status: false}
      json_error_response(response)
    end
  end

  def change_password
    @user = User.find_by(email: params[:email])
    if @user && params[:password]
      begin
        puts @user.update(password: params[:password])
        response = { message: Message.password_changed, status: true}
        json_response(response)
      rescue
        response = { message: Message.Unable_to_process, status: false}
        json_error_response(response)
      end
    else
      response = { message: Message.user_not_found, status: false}
      json_error_response(response)
    end
  end

  def show
    response = { message: Message.updated, user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
    json_response(response)
  end

  def index
    users = User.all
    all_users = users.collect{|user| user_obj(user)}
    response = { auth_token: auth_token, users: all_users}
    json_response(response)
  end

  def all_patients
    users = User.where(role: "patient")
    all_users = users.collect{|user| patient_obj(user)}
    response = { auth_token: auth_token, users: all_users}
    json_response(response)
  end

  def patient_detail
    response = { message: Message.updated, user: patient_obj(@user), auth_token: auth_token }
    json_response(response)
  end

  def search_patients
    if params[:name].present?
      users = User.find_by_sql("Select * from users WHERE role = 0 AND (LOWER(first_name) ILIKE LOWER('%#{params[:name]}%') OR LOWER(last_name) ILIKE LOWER('%#{params[:name]}%'))")
    elsif params[:email].present?
      users = User.find_by_sql("Select * from users WHERE role = 0 AND LOWER(email) ILIKE LOWER('%#{params[:email]}%')")
    end
    all_users = users.collect{|user| patient_obj(user)}
    response = { auth_token: auth_token, users: all_users}
    json_response(response)
  end

  def attempt_quiz
    user_quiz = UserQuiz.create!(user_quiz_params)
    if user_quiz.present?
      response = { auth_token: auth_token, user_quiz: user_quiz}
      json_response(response, :created)
    else
      response = { message: "Something went wrong.", status: false}
      json_error_response(response)
    end
  end

  private
    def set_user
      @user = User.find_by_id(params[:id])
    end

    def user_obj(user)
      user_quizes = UserQuiz.where(user_id: user.id)
      user.attributes.merge(avatar: user.avatar.url, user_quizes: user_quizes.collect{|user_quiz| user_quiz.user_quiz_obj })
    end

    def patient_obj(user)
      query_spots = QuerySpot.where(user_id: user.id)
      user.attributes.merge(avatar: user.avatar.url, query_spots: query_spots.collect{|query_spot| query_spot.query_spot_obj })
    end

    def generate_password(id)
      o = [('0'..'9'), ('a'..'z')].map(&:to_a).flatten
      string = (0...6).map { o[rand(o.length)] }.join
      return string+id.to_s
    end

    def user_params
      params.permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :gender,
        :is_activated,
        :dob,
        :contact_no,
        :role,
        :avatar,
        :confirmation_code
      )
    end

    def user_quiz_params
      params[:completed] = true
      params.permit(
        :user_id,
        :quiz_id,
        :risk,
        :skin_type,
        :completed
      )
    end

  def social_params
    params[:SocialLogIn] = true
    params.permit(
      :email,
      :contact_no,
      :uid,
      :SocialLogIn
    )
  end
end


