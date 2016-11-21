class ViewObject
  MethodNotImplemented = Class.new(StandardError)

  def with_view_helpers(helpers)
    @view_helpers = helpers
    self
  end

  protected

  attr_accessor :view_helpers
end
