require 'test_helper'

class Wikis::NavControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get wikis_nav_edit_url
    assert_response :success
  end

  test "should get update" do
    get wikis_nav_update_url
    assert_response :success
  end

end
