class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_request, only: [ :create, :forget_password, :social_login_in, :resend_otp, :check_email, :create_reminder]
  before_action :set_user, only: [:update, :show, :patient_detail, :update_user, :update_contact_no]
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.find_by(email: params[:email])
    unless user.present?
      params[:confirmation_code] = rand.to_s[2..5] if params[:contact_no].present?
      params[:number_verified] = true
      params[:is_activated] = true if params[:role] != "doctor"
      user = User.create!(user_params)
      # UserMailer.with(email: user.email, code: params[:confirmation_code]).confirmation_email.deliver_now
      # @client = Twilio::REST::Client.new('AC9827bb27753b38381bfb64d9be36a293', '4106dd3af075a677765c5f1d3cb22913')
      # begin
      #   @client.messages.create(
      #     from: '+17078279112',
      #     to: "#{user.contact_no}",
      #     body: "Your DermPro verification code is #{params[:confirmation_code]}"
      #   )
      # rescue Exception => e
      #   puts "Not a valid phone Number, caught exception #{e}"
      # end
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, user: ActiveModelSerializers::SerializableResource.new(user), auth_token: auth_token }
      json_response(response, :created)
    else
      response = { message: Message.already_exists, email_already_exist: true }
      json_error_response(response)
    end
  end

  def resend_otp
    @user = User.find_by_id(params[:user_id])
    if @user.present?
      confirmation_code = rand.to_s[2..5] if @user.contact_no.present?
      @user.update(confirmation_code: confirmation_code)
      @client = Twilio::REST::Client.new('AC9827bb27753b38381bfb64d9be36a293', '4106dd3af075a677765c5f1d3cb22913')
      begin
        @client.messages.create(
          from: '+17078279112',
          to: "#{@user.contact_no}",
          body: "Your DermPro verification code is #{confirmation_code}"
        )
      rescue Exception => e
        puts "Not a valid phone Number, caught exception #{e}"
      end
      response = { message: Message.updated, user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
      json_response(response)
    else
      response = { message: "User not found with ID = #{params[:user_id]}"}
      json_error_response(response)
    end
  end

  def verify_number
    @user = User.find_by_confirmation_code(params[:confirmation_code])
    if @user.present?
      @user.update(number_verified: true)
      response = { message: Message.updated, user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
      json_response(response)
    else
      response = { message: "Invalid otp = #{params[:confirmation_code]}"}
      json_error_response(response)
    end
  end

  def check_email
    @user = User.find_by_email(params[:email])
    if @user.present?
      response = { message: "User email already exist"}
      json_error_response(response)
    else
        response = { message: "You can use this email", user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
        json_response(response)
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

  def update_contact_no
    if @user.present?
      if @user.update(contact_no: params[:contact_no])
        params[:confirmation_code] = rand.to_s[2..5] if params[:contact_no].present?
        @client = Twilio::REST::Client.new('AC9827bb27753b38381bfb64d9be36a293', '4106dd3af075a677765c5f1d3cb22913')
        begin
          @client.messages.create(
            from: '+17078279112',
            to: "#{@user.contact_no}",
            body: "Your DermPro verification code is #{params[:confirmation_code]}"
          )
        rescue Exception => e
          puts "Not a valid phone Number, caught exception #{e}"
        end
        response = { message: Message.account_created, user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
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

  def update_user
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
        response = { message: Message.password_sent, user: ActiveModelSerializers::SerializableResource.new(@user), status: true}
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
    response = { message: "User Detail", user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
    json_response(response)
  end

  def index
    users = User.all
    all_users = users.collect{|user| user_obj(user)}
    response = { auth_token: auth_token, users: all_users}
    json_response(response)
  end

  def all_patients
    users = User.where(role: "patient").order('id desc')
    all_users = users.collect{|user| patient_obj(user)}
    response = { auth_token: auth_token, users: all_users}
    json_response(response)
  end

  def patient_detail
    response = { message: "patient detail", user: patient_obj(@user), auth_token: auth_token }
    json_response(response)
  end

  def search_patients
    if params[:search].present?
      users = User.find_by_sql("Select * from users WHERE role = 0 AND (LOWER(first_name) ILIKE LOWER('%#{params[:search]}%') OR LOWER(last_name) ILIKE LOWER('%#{params[:search]}%') OR LOWER(email) ILIKE LOWER('%#{params[:search]}%'))")
    else
      users = User.find_by_sql("Select * from users WHERE role = 0")
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

  def create_reminder
    reminder = Reminder.create!(reminder_params)
    if reminder.present?
      response = { auth_token: auth_token, reminder: reminder}
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
    pending_qs = false
    user.query_spots.each do |qs|
      pending_qs = true if qs.feedbacks.blank?
    end
    query_spots = QuerySpot.where(user_id: user.id).order("created_at DESC")
    user.attributes.merge(pending_qs:  pending_qs , created_at: user.created_at.strftime("%d-%b-%Y %H:%M"), avatar: user.avatar.url, query_spots: query_spots.collect{|query_spot| query_spot.query_spot_obj })
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
      :doctor_type,
      :gender,
      :is_activated,
      :dob,
      :contact_no,
      :role,
      :avatar,
      :fcm_token,
      :number_verified,
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

  def reminder_params
    params.permit(
      :title,
      :description,
      :user_id
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


