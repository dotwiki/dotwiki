require 'test_helper'

class Wikis::RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get wikis_requests_new_url
    assert_response :success
  end

  test "should get edit" do
    get wikis_requests_edit_url
    assert_response :success
  end

  test "should get show" do
    get wikis_requests_show_url
    assert_response :success
  end

  test "should get create" do
    get wikis_requests_create_url
    assert_response :success
  end

  test "should get update" do
    get wikis_requests_update_url
    assert_response :success
  end

  test "should get merge" do
    get wikis_requests_merge_url
    assert_response :success
  end

  test "should get reject" do
    get wikis_requests_reject_url
    assert_response :success
  end

end
