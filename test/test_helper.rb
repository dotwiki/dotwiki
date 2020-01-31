ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
# require 'minitest/reporters'
# Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_user(u)
    visit new_user_path
    fill_in "user[email]", with: u[:email]
    fill_in "user[password]", with: u[:password]
    find('#user_agreement_label').click
    find('#user_resister_submit').click
    User.last.activate!
    User.last
  end

  def login_user(u)
    visit login_url
    fill_in "email", with: u[:email]
    fill_in "password", with: u[:password]
    find('#user_login_submit').click
  end

  def fixture_user
    # fixtureを使うと登録時のnoticeなどがないので注意
    user = users(:mario)
    user.update!(password: 'password')
    visit login_url
    fill_in "email", with: user[:email]
    fill_in "password", with: 'password'
    find('#user_login_submit').click
    user
  end
end
