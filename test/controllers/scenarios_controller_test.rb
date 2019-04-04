require 'test_helper'

class ScenariosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get scenarios_new_url
    assert_response :success
  end

end
