require 'test_helper'

class Api::V1::TopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_topics_index_url
    assert_response :success
  end

end
