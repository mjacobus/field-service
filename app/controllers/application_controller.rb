class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  protected

  def create_decorator(*args)
    klass = args.shift
    klass.new(*args).with_view_helpers(view_context)
  end
end
