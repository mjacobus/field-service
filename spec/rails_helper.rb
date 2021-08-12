ENV['RAILS_ENV'] ||= 'test'

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-lcov'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::LcovFormatter
    ]
  )

  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.report_with_single_file = true
    c.single_report_path = 'coverage/lcov.info'
  end

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
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require "clearance/rspec"

require File.expand_path(File.dirname(__FILE__) + '/support/blueprints')
require File.expand_path(File.dirname(__FILE__) + '/support/api/controller_spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/support/endpoint_spec_helper')
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include EndpointSpecHelper, type: :endpoint
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include Api::ControllerSpecHelper, type: :controller
end

def t(*args)
  I18n.t(*args)
end

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

def assign_territory(territory, publisher)
  TerritoryAssigning.new.perform(
    territory_id: territory.id,
    publisher_id: publisher.id
  )
end
