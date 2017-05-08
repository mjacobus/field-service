class ActiveRecordBaseDecorator < BaseDecorator
  def title_for(attribute_name)
    item.class.human_attribute_name(attribute_name)
  end

  protected

  # http://zurb.com/playground/foundation-icon-fonts-3
  def button_link_with_icon(url, icon, button_type = nil, options = {})
    options = options.merge(class: "button #{button_type}")
    content = content_tag(:i, nil, class: "fi-#{icon}")

    if options[:text]
      text = content_tag(:div, options[:text])

      content = content_tag(:span) do
        content + text
      end
    end

    link_to(url, options) { content }
  end
end
