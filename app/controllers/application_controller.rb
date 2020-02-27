class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error

	private
	def record_not_found_error
		render json: { errors: ['Object was not found'] }, status: :not_found
	end
end