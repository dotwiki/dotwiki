require 'test_helper'

class Users::NoticeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_notice_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_notice_destroy_url
    assert_response :success
  end

end
