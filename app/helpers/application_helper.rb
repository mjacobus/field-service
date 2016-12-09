module ApplicationHelper
  def breadcrumbs(parts)
    return if parts.empty?
    content_for(:breadcrumbs) do
      render partial: 'breadcrumbs', locals: { parts: parts }
    end
  end

  def breadcrumbs_for(object)
    raise "Needs to implement 'breadcrumbs'" unless object.respond_to?(:breadcrumbs)
    breadcrumbs(object.breadcrumbs)
  end

  def button_group(*buttons)
    render  partial: 'button_group', locals: {
      buttons: buttons,
      type: ''
    }
  end

  def small_button_group(*buttons)
    render  partial: 'button_group', locals: {
      buttons: buttons,
      type: 'small'
    }
  end

  def page_title(title)
    content_for(:title, title)
  end
end
