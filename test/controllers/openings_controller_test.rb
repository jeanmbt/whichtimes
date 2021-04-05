require 'test_helper'

class OpeningsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get openings_edit_url
    assert_response :success
  end

  test "should get update" do
    get openings_update_url
    assert_response :success
  end

end
