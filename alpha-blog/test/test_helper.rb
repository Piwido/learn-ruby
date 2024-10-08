ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'simplecov'

require 'rails/test_help'
Dir[Rails.root.join('test', 'support', '**', '*.rb')].each { |f| require f }
SimpleCov.start

module ActiveSupport
  class TestCase
    include ControllerMacros
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
