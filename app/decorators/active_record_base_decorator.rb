class ActiveRecordBaseDecorator < BaseDecorator

  protected

  # http://zurb.com/playground/foundation-icon-fonts-3
  def button_link_with_icon(url, icon, button_type = nil, options = {})
    options = options.merge(class: "button #{button_type}")

    link_to url, options do
      content_tag(:i, nil, class: "fi-#{icon}")
    end
  end
end
