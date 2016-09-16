require 'test_helper'

class TrackingControllerTest < ActionDispatch::IntegrationTest
  test "should get task_id:integer" do
    get tracking_task_id:integer_url
    assert_response :success
  end

  test "should get user_id:integer" do
    get tracking_user_id:integer_url
    assert_response :success
  end

  test "should get change:text" do
    get tracking_change:text_url
    assert_response :success
  end

end
