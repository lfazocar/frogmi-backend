require "test_helper"

class FeaturesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get features_url, as: :json
    assert_response :success
  end
end
