class Api::V1::QuerySpotsController < Api::V1::BaseController
  # POST /signup
  # return authenticated token upon signup
  def create
    query_spot = QuerySpot.create!(query_spot_params)
    send_notification([current_user.fcm_token], "Sample Title", "Sample Description", "Query Spot", current_user.id)
    notification = Notification.create!(user_id: current_user.id, title: "Sample Title", description: "Sample Description", notification_type: "Query Spot")
    response = { message: "query spot created successfully", query_spot: query_spot.query_spot_obj, auth_token: auth_token }
    json_response(response)
  end

  private

  def query_spot_params
    params.permit( {images: []}, :message, :user_id )
  end

end
