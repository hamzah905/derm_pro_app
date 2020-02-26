class Api::V1::TopicsController < Api::V1::BaseController

  def index
    topics = Topic.all
    response = { auth_token: auth_token, topics: topics}
    json_response(response)
  end

end
