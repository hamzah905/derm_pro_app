require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get account_verification" do
    get home_account_verification_url
    assert_response :success
  end

end
