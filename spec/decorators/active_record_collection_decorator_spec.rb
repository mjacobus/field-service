require 'rails_helper'

class DummyItemDecoratorClass
  attr_accessor :view_helpers, :item

  def initialize(item)
    @item = item
  end

  def with_view_helpers(view_helpers)
    @view_helpers = view_helpers
    self
  end
end

RSpec.describe ActiveRecordCollectionDecorator do
  before do
    klass = Class.new(ActiveRecordCollectionDecorator) do
      def index_url
        '/resource_name'
      end

      def item_decorator_class
        DummyItemDecoratorClass
      end
    end

    @item = double(id: 1)
    @collection = [@item]
    @decorator ||= klass.new(@collection)
  end

  it 'extends BaseDecorator' do
    assert @decorator.is_a?(BaseDecorator)
  end

  it 'can get index url' do
    assert_equal '/resource_name', @decorator.index_url
  end

  it 'can get new url' do
    assert_equal '/resource_name/new', @decorator.new_url
  end

  it 'index_url must be implemented' do
    subject = ActiveRecordCollectionDecorator.new([])

    assert_raises(NotImplementedError) do
      subject.index_url
    end
  end

  it 'item_decorator_class must be implemented' do
    subject = ActiveRecordCollectionDecorator.new([])

    exception = assert_raises(NotImplementedError) do
      subject.item_decorator_class
    end
  end

  it 'each yields item view' do
    view_helpers = double(:helpers)

    @decorator.with_view_helpers(view_helpers)
    collected = []

    @decorator.each do |item|
      collected << item
    end

    decorated_item = collected.first

    assert_same @item, decorated_item.item
    assert decorated_item.is_a?(DummyItemDecoratorClass), "Is actually a #{collected.first.class}"
    assert_same view_helpers, decorated_item.view_helpers
  end
end
