class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def create_view(*args)
    klass = args.shift
    klass.new(*args).with_view_helpers(view_context)
  end
end
