require_relative '../spec/common'

require 'rails/test_help'
require 'object_comparator/minitest'
require 'mocha/mini_test'
require 'clearance/test_unit'

require File.expand_path(File.dirname(__FILE__) + '/blueprints')

class ActiveSupport::TestCase
  include ObjectComparator::Minitest
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

    assert_not_nil delegated.send(method), 'cannot check if delegates if value is nil'
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
        password: password
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
