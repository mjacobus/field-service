class BaseDecorator
  MethodNotImplemented = Class.new(StandardError)

  def with_view_helpers(helpers)
    @view_helpers = helpers
    self
  end

  protected

  def t(*args)
    view_helpers.t(*args)
  end

  attr_accessor :view_helpers
end
