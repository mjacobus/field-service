class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  protected

  def create_decorator(*args)
    klass = args.shift
    klass.new(*args).with_view_helpers(view_context)
  end

  def search_params
    allowed = %i[assigned_to_ids pending_return]
    params.symbolize_keys.select do |key, _value|
      allowed.include?(key)
    end
  end
end
