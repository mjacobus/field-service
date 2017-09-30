class ActiveRecordModelDecorator < ActiveRecordBaseDecorator
  def edit_url
    "#{index_url}/#{item.to_param}/edit"
  end

  def new_url
    "#{index_url}/new"
  end

  def url
    "#{index_url}/#{item.to_param}"
  end

  def index_url
    raise NotImplementedError
  end

  def form_url
    item.persisted? ? url : index_url
  end

  def form_object
    item
  end

  def show_button
    button_link_with_icon url, :eye, :secondary
  end

  def edit_button
    button_link_with_icon edit_url, :pencil, :success, { text: t('links.edit' ) }
  end

  def destroy_button(url = nil, icon: 'x', confirm_message: nil, button_class: 'alert', title: nil, text: nil)
    url ||= self.url
    confirm_message ||= t('messages.confirm_destroy')
    title ||= t('links.destroy')
    text = content_tag(:span, ' ' + (text || t('links.destroy')))

    link_to url, method: :delete, data: { confirm: confirm_message }, class: "button #{button_class}", title: title do
      content_tag(:i, nil, class: "fi-#{icon}") + text
    end
  end

  def cancel_button
    button_link_with_icon index_url, 'arrow-left', :alert, text: t('links.back')
  end

  def save_button
    content_tag :button, class: 'button large success', title: t('save', default: 'Save') do
      t('links.save')
    end
  end

  private

  def item
    __getobj__
  end
end
