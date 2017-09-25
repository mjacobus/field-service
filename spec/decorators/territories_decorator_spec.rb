require 'rails_helper'

RSpec.describe TerritoriesDecorator do
  let(:fake_view_helpers) { FakeViewHelpers.new }

  before do
    @item = double(id: 1)
    @collection = [@item]
    @decorator ||= TerritoriesDecorator.new(@collection).with_view_helpers(fake_view_helpers)
  end

  it 'is a ActiveRecordCollectionDecorator' do
    assert @decorator.is_a?(ActiveRecordCollectionDecorator)
  end

  it 'item class is TerritoryDecorator' do
    assert_equal TerritoryDecorator, @decorator.item_decorator_class
  end

  it 'can get index url' do
    assert_equal '/territories', @decorator.index_url
  end

  it 'can get new url' do
    assert_equal '/territories/new', @decorator.new_url
  end

  it 'each yields item view' do
    collected = []

    @decorator.each do |item|
      collected << item
    end

    assert_same @item, collected.first.send(:item)
    assert collected.first.is_a?(TerritoryDecorator)
  end

  it '#breadcrumbs returns correct collection' do
    expected = [
      ['t.titles.territories']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end
end
