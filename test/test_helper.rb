ENV['RAILS_ENV'] ||= 'test'

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start 'rails' do
    add_filter 'app/channels/application_cable/channel.rb'
    add_filter 'app/channels/application_cable/connection.rb'
    add_filter 'app/jobs/application_job.rb'
    add_filter 'app/mailers/application_mailer.rb'
    add_group "Views Objects", "app/view_objects"
  end
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.expand_path(File.dirname(__FILE__) + '/blueprints')
require "mocha/mini_test"

class ActiveSupport::TestCase
  teardown do
    DatabaseCleaner.clean
  end
end
