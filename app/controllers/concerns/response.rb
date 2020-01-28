module Response
  def json_response(object, status = :ok)
    object["success"] = true
    object["status"] = status
    render json: {data: object}
  end

  def json_error_response(object, status = :unprocessable_entity)
    object["success"] = false
    object["status"] = status
    render json: {data: object}
  end
end

