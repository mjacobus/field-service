class ActiveRecordCollectionDecorator < ActiveRecordBaseDecorator
  def index_url
    raise NotImplementedError
  end

  def new_url
    "#{index_url}/new"
  end

  def item_decorator_class
    raise NotImplementedError
  end

  def each
    collection.each do |item|
      yield(create_item_decorator(item))
    end
  end

  def new_button
    link_to new_url, class: 'button' do
      content_tag(:i, nil, class: 'fi-plus')
    end
  end

  protected

  def create_item_decorator(item)
    item_decorator_class.new(item).with_view_helpers(view_helpers)
  end

  def collection(*_args)
    __getobj__
  end
end
