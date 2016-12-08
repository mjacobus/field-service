class BreadcrumbsRenderer
  attr_reader :separator

  def initialize(view_context, separator = '&gt;')
    @view_context = view_context
    @separator = separator
  end

  def render(parts)
    [].tap do |html|
      parts.each do |part|
        html << create_part(part)
      end
    end.join(" #{separator} ").html_safe
  end

  private

  def create_part(part)
    if part.length == 1
      return part[0]
    end

    view_context.link_to(*part)
  end

  attr_reader :view_context
end
