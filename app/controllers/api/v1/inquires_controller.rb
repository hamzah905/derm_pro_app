class Api::V1::InquiresController < Api::V1::BaseController
  # POST /signup
  # return authenticated token upon signup
  def create
    inquiry = Inquiry.create!(inquiry_params)
    response = { message: "Inquiry created successfully", inquiry: inquiry, auth_token: auth_token }
    json_response(response)
  end

  private

    def inquiry_params
      params.permit( {images: []}, :message, :user_id )
    end
end
