require 'test_helper'

class TerritoriesDecoratorTest < TestCase
  def setup
    @item = stub(id: 1)
    @collection = [@item]
    @decorator ||= TerritoriesDecorator.new(@collection).with_view_helpers(fake_view_helpers)
  end

  test 'is a ActiveRecordCollectionDecorator' do
    assert @decorator.is_a?(ActiveRecordCollectionDecorator)
  end

  test 'item class is TerritoryDecorator' do
    assert_equal TerritoryDecorator, @decorator.item_decorator_class
  end

  test 'can get index url' do
    assert_equal '/territories', @decorator.index_url
  end

  test 'can get new url' do
    assert_equal '/territories/new', @decorator.new_url
  end

  test 'each yields item view' do
    collected = []

    @decorator.each do |item|
      collected << item
    end

    assert_same @item, collected.first.send(:item)
    assert collected.first.is_a?(TerritoryDecorator)
  end

  test '#breadcrumbs returns correct collection' do
    expected = [
      ['t.titles.territories']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end
end
