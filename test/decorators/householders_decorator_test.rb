require 'test_helper'

class HouseholdersDecoratorTest < TestCase
  def setup
    @territory = stub(id: ':tid', name: 'T1')
    @item = stub(id: 1)
    @collection = [@item]
    @decorator ||= HouseholdersDecorator.new(@collection, @territory)
    @decorator = @decorator.with_view_helpers(fake_view_helpers)
  end

  test 'is a ActiveRecordCollectionDecorator' do
    assert @decorator.is_a?(ActiveRecordCollectionDecorator)
  end

  test 'item class is HouseholderDecorator' do
    assert_equal HouseholderDecorator, @decorator.item_decorator_class
  end

  test 'can get index url' do
    assert_equal '/territories/:tid/householders', @decorator.index_url
  end

  test 'can get new url' do
    assert_equal '/territories/:tid/householders/new', @decorator.new_url
  end

  test 'each yields item view' do
    collected = []

    @decorator.each do |item|
      collected << item
    end

    assert_same @item, collected.first.send(:item)
    assert collected.first.is_a?(HouseholderDecorator)
  end

  test '#territory return territory' do
    assert_same @territory, @decorator.territory
  end

  test '#territory raises when territory is not set' do
    error = assert_raises(StandardError) do
      HouseholdersDecorator.new(@item).territory
    end

    assert_equal 'territory was not set', error.message
  end

  test '#breadcrumbs returns correct collection' do
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.territories', '/territories'],
      ['T1', '/territories/:tid'],
      ['t.titles.householders']
    ]

    assert_equal expected, actual
  end
end
