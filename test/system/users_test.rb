require "application_system_test_case"

class WikisTest < ApplicationSystemTestCase
  setup do
    @new_user = {
      name: Faker::Games::Zelda.character,
      email: Faker::Internet.email,
      password: "password",
    }
  end

  test "visiting login path" do
    visit login_path
    assert_text "ログイン"
  end

  test "create user" do
    visit login_path
    click_link "ユーザー登録はこちら"
    assert_text "ユーザー登録"
    fill_in "user[email]", with: @new_user[:email]
    fill_in "user[password]", with: @new_user[:password]
    find("#user_agreement_label").click
    click_button "登録"
    assert_text "確認メールを送信しました"
  end

  test "receive first notification if user resistered" do
    user = create_user(@new_user)
    login_user(@new_user)
    visit user_notices_path(user.id)
    assert_text "通知一覧"
    assert_text "ようこそ"
  end
end
