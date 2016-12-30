ENV['RAILS_ENV'] ||= 'test'

if ENV["COVERAGE"]
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ])

  SimpleCov.start 'rails' do
    add_filter 'app/channels/application_cable/channel.rb'
    add_filter 'app/channels/application_cable/connection.rb'
    add_filter 'app/jobs/application_job.rb'
    add_filter 'app/mailers/application_mailer.rb'
    add_group "Decorators", "app/decorators"
  end
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.expand_path(File.dirname(__FILE__) + '/blueprints')
require "mocha/mini_test"
require "clearance/test_unit"

class ActiveSupport::TestCase
  teardown do
    DatabaseCleaner.clean
  end

  def t(*args)
    I18n.t(*args)
  end

  def assert_delegates(method, delegator, delegated)
    message = "does not delegate #{method} to #{delegated}"

    assert_respond_to delegator, method, message
    assert_respond_to delegated, method, "delegated does not respond to #{method}"

    assert_equal(
      delegator.send(method),
      delegated.send(method),
      message
    )

    assert_equal(
      delegator.send(method),
      delegated.send(method),
      message
    )

    assert_not_nil delegated.send(method), "cannot check if delegates if value is nil"
  end
end

class ControllerTestCase < ActionDispatch::IntegrationTest
  def current_user
    @current_user ||= User.make!(password: 'admin')
  end

  def sign_in_as(user, password = 'admin')
    post session_url, params: {
      session: {
        email: user.email,
        password: password,
      }
    }
  end
end

class TestCase < ActiveSupport::TestCase
  def fake_view_helpers
    @fake_view_helpers ||= FakeViewHelpers.new
  end
end

class FakeViewHelpers
  def t(arg)
    ['t', arg].join('.')
  end
end

class HelperTestCase < ActionView::TestCase
end
