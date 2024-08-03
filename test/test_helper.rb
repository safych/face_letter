ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "devise/test/integration_helpers"
require "capybara/rails"
require "capybara/minitest"

Capybara.default_driver = :selenium_chrome

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)

    fixtures :all

    include Capybara::DSL
    include Capybara::Minitest::Assertions
    include Devise::Test::IntegrationHelpers
  
    teardown do
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end
