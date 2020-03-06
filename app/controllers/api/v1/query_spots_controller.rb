class Api::V1::QuerySpotsController < Api::V1::BaseController
  before_action :set_query_spot, only: [:query_spot_feedback]
  # POST /signup
  # return authenticated token upon signup
  def create
    query_spot = current_user.query_spots.create!(query_spot_params)
    send_notification([current_user.fcm_token], "Sample Title", "Sample Description", "Query Spot", current_user.id)
    notification = Notification.create!(user_id: current_user.id, title: "Sample Title", description: "Sample Description", notification_type: "Query Spot")
    response = { message: "query spot created successfully", query_spot: query_spot.query_spot_obj, auth_token: auth_token }
    json_response(response)
  end

  def query_spot_feedback
    feedback = @query_spot.feedbacks.create!(feedback_params)
    send_notification([@query_spot.user.fcm_token], "Sample Title", "Sample Description", "Query Spot", @query_spot.user.id) if (current_user && current_user.role == "doctor")
    notification = Notification.create!(user_id: @query_spot.user.id, title: "Sample Title", description: "Sample Description", notification_type: "Query Spot")
    response = { message: "query spot created successfully", feedback: feedback.feedback_obj}
    json_response(response)
  end

  def show
    query_spot = QuerySpot.find_by_id(params[:id])
    response = { message: "Query Spot Detail", query_spot: query_spot.query_spot_obj, auth_token: auth_token }
    json_response(response)  end
  private

  def set_query_spot
    @query_spot = QuerySpot.find_by_id(params[:query_spot_id])
  end

  def feedback_params
    params[:user_id] = current_user.id if current_user.present?
    params[:user_role] = current_user.role if current_user.present?
    params.permit( :user_id, :user_role, :feedback_type, :image , :message )
  end

  def query_spot_params
    params.permit( {images: []}, :message )
  end

end
