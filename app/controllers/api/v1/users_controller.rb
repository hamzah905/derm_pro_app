class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authorize_request, only: [ :create, :forget_password, :social_login_in]
  before_action :set_user, only: :update
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.find_by(email: params[:email])
    unless user.present?
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
    if @user.update(user_params)
      response = { message: Message.updated, user: ActiveModelSerializers::SerializableResource.new(@user), auth_token: auth_token }
      json_response(response)
    else
      response = { message: Message.Unable_to_Update, auth_token: auth_token }
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

  def index
    users = User.all
    response = { auth_token: auth_token, users: users}
    json_response(response)
  end

  def contact_us
    if Inquiry.create(inquiry_params)
      response = { message: Message.inquiry_created, success: true, auth_token: auth_token }
    else
      response = { message: Message.unable_to_create_inquiry, success: false, auth_token: auth_token }
    end
    json_response(response, :created)
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def inquiry_params
      params.permit(
        :name,
        :email,
        :phone,
        :description
      )
    end

    def generate_password(id)
      o = [('0'..'9'), ('a'..'z')].map(&:to_a).flatten
      string = (0...6).map { o[rand(o.length)] }.join
      return string+id.to_s
    end

    def user_params
      params[:registered] = true
      params.permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :gender,
        :dob,
        :height,
        :martial_status,
        :education,
        :religious_education,
        :cast,
        :school_of_thoughts,
        :brothers,
        :sisters,
        :father_occupation,
        :occupation,
        :monthly_income,
        :residence,
        :city,
        :contact_no,
        :requirement
      )
    end

  def social_params
    params[:SocialLogIn] = true
    params.permit(
      :name,
      :email,
      :phone,
      :uid,
      :SocialLogIn
    )
  end
end


