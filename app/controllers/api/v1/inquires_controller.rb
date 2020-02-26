class Api::V1::InquiresController < Api::V1::BaseController
  # POST /signup
  # return authenticated token upon signup
  def create
    inquiry = Inquiry.create!(inquiry_params)
    response = { message: "Inquiry created successfully", inquiry: inquiry_obj(inquiry), auth_token: auth_token }
    json_response(response)
  end

  def index
    inquiries = current_user.inquiries
    all_inquiries = inquiries.collect{|inquiry| inquiry_obj(inquiry)}
    response = { auth_token: auth_token, inquiries: all_inquiries}
    json_response(response)
  end

  private

    def inquiry_params
      params.permit( {images: []}, :message, :user_id )
    end


    def inquiry_obj(inquiry)
      inquiry_image = []
      images = inquiry.images.present? ? inquiry.images.count.times{ |index|  inquiry_image << inquiry.images[index].url } : ""
      inquiry.attributes.merge(images: inquiry_image.present? ? inquiry_image : "").except("updated_at")
    end
end
