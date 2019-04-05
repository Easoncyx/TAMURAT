require 'test_helper'

class ScaleControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get scale_new_url
    assert_response :success
  end

end
