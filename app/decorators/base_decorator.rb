require 'uri'

class BaseDecorator < SimpleDelegator
  def with_view_helpers(helpers)
    @view_helpers = helpers
    self
  end

  private

  def t(*args)
    view_helpers.t(*args)
  end

  def l(*args)
    view_helpers.l(*args)
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

  def params
    view_helpers.params
  end

  def encode(string)
    URI.encode(string.to_s)
  end

  attr_accessor :view_helpers
end
