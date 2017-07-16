require 'test_helper'

class PublishersDecoratorTest < TestCase
  def setup
    @item = stub(id: 1)
    @collection = [@item]
    @decorator ||= PublishersDecorator.new(@collection).with_view_helpers(fake_view_helpers)
  end

  test 'is a ActiveRecordCollectionDecorator' do
    assert @decorator.is_a?(ActiveRecordCollectionDecorator)
  end

  test 'item class is PublisherDecorator' do
    assert_equal PublisherDecorator, @decorator.item_decorator_class
  end

  test 'can get index url' do
    assert_equal '/publishers', @decorator.index_url
  end

  test 'can get new url' do
    assert_equal '/publishers/new', @decorator.new_url
  end

  test 'each yields item view' do
    collected = []

    @decorator.each do |item|
      collected << item
    end

    assert_same @item, collected.first.send(:item)
    assert collected.first.is_a?(PublisherDecorator)
  end

  test '#breadcrumbs returns correct collection' do
    expected = [
      ['t.titles.publishers']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end
end
