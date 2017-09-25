ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  )

  SimpleCov.start 'rails' do
    add_filter 'app/channels/application_cable/channel.rb'
    add_filter 'app/channels/application_cable/connection.rb'
    add_filter 'app/jobs/application_job.rb'
    add_filter 'app/mailers/application_mailer.rb'
    add_group 'Decorators', 'app/decorators'
    add_group 'Services', 'app/services'
  end
end

FIXTURES_PATH = File.expand_path('../fixtures/', __FILE__)

require File.expand_path('../../config/environment', __FILE__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

class FakeViewHelpers
  def t(arg)
    ['t', arg].join('.')
  end
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

  expect(delegated.send(method)).not_to(be_nil, 'cannot check if delegates if value is nil')
end
