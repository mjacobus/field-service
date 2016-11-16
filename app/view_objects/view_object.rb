class ViewObject
  def with_view_helpers(helpers)
    other = dup
    other.view_helpers = helpers
    other
  end

  protected

  attr_accessor :view_helpers
end
