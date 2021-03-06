class Api::V1::QuerySpotsController < Api::V1::BaseController
  before_action :set_query_spot, only: [:query_spot_feedback, :update_query_spot]
  skip_before_action :authorize_request, only: [ :update_query_spot]
  # POST /signup
  # return authenticated token upon signup
  def create
    query_spot = current_user.query_spots.create!(query_spot_params)
    send_notification([current_user.fcm_token], "Query Spot Recieved", "Thanks for using dermpro app, we will get back to you shortly.", "Query Spot", current_user.id, query_spot.id)
    notification = Notification.create!(user_id: current_user.id, title: "Query Spot Recieved", description: "Thanks for using dermpro app, we will get back to you shortly.", notification_type: "Query Spot")
    response = { message: "query spot created successfully", query_spot: query_spot.query_spot_obj, auth_token: auth_token }
    json_response(response)
  end

  def update_query_spot
    @query_spot.update(query_spot_params)
    response = { message: "query spot updated successfully", query_spot: @query_spot.query_spot_obj, auth_token: auth_token }
    json_response(response)
  end

  def query_spot_feedback
    feedback = @query_spot.feedbacks.create!(feedback_params)
    send_notification([@query_spot.user.fcm_token], "Query Spot Feedback", feedback.message, "Query Spot", @query_spot.user.id, @query_spot.id) if (current_user && current_user.role == "doctor")
    notification = Notification.create!(user_id: @query_spot.user.id, title: "Sample Title", description: "Sample Description", notification_type: "Query Spot", obj_id: @query_spot.id)
    response = { message: "query spot created successfully", feedback: feedback.feedback_obj}
    json_response(response)
  end

  def show
    query_spot = QuerySpot.find_by_id(params[:id])
    response = { message: "Query Spot Detail", query_spot: query_spot.query_spot_obj, auth_token: auth_token }
    json_response(response)
  end

  def queryspot_listing_by_month
    query_spots = QuerySpot.where(user_id: params[:user_id]).group_by { |t| t.created_at.beginning_of_month }
    response = { auth_token: auth_token, query_spots: query_spots}
    json_response(response)
  end
  private

  def set_query_spot
    @query_spot = QuerySpot.find_by_id(params[:query_spot_id])
  end

  def feedback_params
    params[:user_id] = current_user.id if current_user.present?
    params[:user_role] = current_user.role if current_user.present?
    params.permit( :user_id, :user_role, :feedback_type, :image , :message, :query_spot_place )
  end

  def query_spot_params
    params.permit( {images: []}, :message, :disease, :query_spot_place, :scan_side )
  end

end
