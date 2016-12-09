class ActiveRecordCollectionDecorator < BaseDecorator
  def initialize(collection)
    @collection = collection
  end

  def index_url
    raise MethodNotImplemented
  end

  def new_url
    "#{index_url}/new"
  end

  def item_decorator_class
    raise MethodNotImplemented
  end

  def each(&block)
    collection.each do |item|
      block.call(create_item_decorator(item))
    end
  end

  def new_button
    link_to 'New', new_url, class: 'button'
  end

  protected

  def create_item_decorator(item)
    item_decorator_class.new(item).with_view_helpers(view_helpers)
  end

  attr_reader :collection
end
