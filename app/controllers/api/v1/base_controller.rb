class Api::V1::BaseController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  include Response
  include ExceptionHandler
  include ApplicationHelper

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def auth_token
    request.headers["Authorization"]
  end
end