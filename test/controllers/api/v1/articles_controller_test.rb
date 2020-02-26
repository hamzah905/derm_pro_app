require 'test_helper'

class Api::V1::ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_articles_index_url
    assert_response :success
  end

end
