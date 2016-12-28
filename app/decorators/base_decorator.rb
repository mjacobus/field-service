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

  def link_to(*args, &block)
    view_helpers.link_to(*args, &block)
  end

  def content_tag(*args, &block)
    view_helpers.content_tag(*args, &block)
  end

  def boolean_to_human(boolean)
    yes_or_no = boolean ? 'yes' : 'no'
    t(yes_or_no)
  end

  attr_accessor :view_helpers
end
