class ActiveRecordModelDecorator < BaseDecorator
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

  def show_button(*args)
    link_to 'Show', url, class: 'button secondary'
  end

  def edit_button(*args)
    link_to 'Edit', edit_url, class: 'button success'
  end

  def destroy_button(*args)
    link_to 'Destroy', url, method: :delete, data: { confirm: 'Are you sure?' }, class: 'button alert'
  end

  protected

  attr_reader :item
end
