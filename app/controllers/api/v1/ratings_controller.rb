class Api::V1::RatingsController < ApplicationController

  def create
    rating = Rating.create!(rating_params)
    response = { message: "rating created successfully", rating: rating, auth_token: auth_token }
    json_response(response)
  end

  def update
    rating = Rating.update!(rating_params)
    response = { message: "rating created successfully", rating: rating, auth_token: auth_token }
    json_response(response)
  end

  private

  def rating_params
    params.permit( :star, :user_id )
  end
end
