class ActiveRecordModelDecorator < ActiveRecordBaseDecorator
  def initialize(item)
    @item = item
  end

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
    raise "not implemented"
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
    button_link_with_icon edit_url, :pencil, :success
  end

  def destroy_button
    link_to url, method: :delete, data: { confirm: t('messages.confirm_destroy') }, class: 'button alert' do
      content_tag(:i, nil, class: "fi-x")
    end
  end

  def cancel_button
    button_link_with_icon index_url, 'arrow-left', :alert
  end

  def save_button
    content_tag :button, class: 'button large success', title: t('save', default: 'Save') do
      content_tag(:i, nil, class: 'fi-save')
    end
  end

  protected

  attr_reader :item
end
