require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Risk Assessment Tool"
  end

  test "should get root" do
    get root_path
    assert_response :success
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get log in" do
    get login_path
    assert_response :success
    assert_select "title", "Log in | #{@base_title}"
  end
  
end
