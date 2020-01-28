class Api::V1::AuthenticationController < Api::V1::BaseController
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    user = User.find_by(email: auth_params[:email])
    json_response(auth_token: auth_token, user: ActiveModelSerializers::SerializableResource.new(user))
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end