require 'test_helper'

class WikisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wiki = wikis(:one)
  end

  test "should get index" do
    get wikis_url
    assert_response :success
  end

  test "should get new" do
    get new_wiki_url
    assert_response :success
  end

  test "should create wiki" do
    assert_difference('Wiki.count') do
      post wikis_url, params: { wiki: { description: @wiki.description, official_url: @wiki.official_url, steam_id: @wiki.steam_id, terms: @wiki.terms, title: @wiki.title } }
    end

    assert_redirected_to wiki_url(Wiki.last)
  end

  test "should show wiki" do
    get wiki_url(@wiki)
    assert_response :success
  end

  test "should get edit" do
    get edit_wiki_url(@wiki)
    assert_response :success
  end

  test "should update wiki" do
    patch wiki_url(@wiki), params: { wiki: { description: @wiki.description, official_url: @wiki.official_url, steam_id: @wiki.steam_id, terms: @wiki.terms, title: @wiki.title } }
    assert_redirected_to wiki_url(@wiki)
  end

  test "should destroy wiki" do
    assert_difference('Wiki.count', -1) do
      delete wiki_url(@wiki)
    end

    assert_redirected_to wikis_url
  end
end
