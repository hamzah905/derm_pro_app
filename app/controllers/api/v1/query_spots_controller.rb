class Api::V1::QuerySpotsController < ApplicationController
  # POST /signup
  # return authenticated token upon signup
  def create
    query_spot = QuerySpot.create!(query_spot_params)
    response = { message: "query_spot created successfully", query_spot: query_spot.query_spot_obj, auth_token: auth_token }
    json_response(response)
  end

  private

    def query_spot_params
      params.permit( {images: []}, :message, :user_id )
    end

end
