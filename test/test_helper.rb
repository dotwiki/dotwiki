ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup_user
    user = users(:mario)
    user.update!(password: 'password')
    visit login_url
    fill_in "login_email", with: user[:email]
    fill_in "login_password", with: 'password'
    find('#user_login').click
    sleep 0.1
  end
end
