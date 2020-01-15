require 'test_helper'

class Users::WatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_watches_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_watches_destroy_url
    assert_response :success
  end

end
