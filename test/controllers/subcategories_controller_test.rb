require 'test_helper'

class SubcategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get subcategories_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get subcategories_destroy_url
    assert_response :success
  end

end
