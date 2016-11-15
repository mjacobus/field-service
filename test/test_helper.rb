ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require File.expand_path(File.dirname(__FILE__) + '/blueprints')


if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.start 'rails' do
    add_filter "spec/"
    add_filter "lib/templates"
    add_filter "lib/generator/rails/custom_controller"
    add_filter "lib/generators/rails/custom_controller/templates/controller.rb"
    add_filter "test/"

    add_group "Lib", "lib"
  end
end

class ActiveSupport::TestCase
  teardown do
    DatabaseCleaner.clean
  end
end
