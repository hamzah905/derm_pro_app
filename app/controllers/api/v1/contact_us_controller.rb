class Api::V1::ContactUsController < Api::V1::BaseController

  def create
    contact_us = ContactUs.create!(contact_us_params)
    response = { message: "contact_us created successfully", contact_us: contact_us, auth_token: auth_token }
    json_response(response)
  end

  private

  def contact_us_params
    params.permit( :title, :description )
  end

end
