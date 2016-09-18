require 'test_helper'

class PreferenceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get preference_index_url
    assert_response :success
  end

  test "should get edit" do
    get preference_edit_url
    assert_response :success
  end

  test "should get update" do
    get preference_update_url
    assert_response :success
  end

end
