require 'rails_helper'

RSpec.describe HouseholdersDecorator do
  let(:fake_view_helpers) { FakeViewHelpers.new }

  before do
    @territory = double(id: ':tid', name: 'T1')
    @item = double(id: 1)
    @collection = [@item]
    @decorator ||= HouseholdersDecorator.new(@collection, @territory)
    @decorator = @decorator.with_view_helpers(fake_view_helpers)
  end

  it 'is a ActiveRecordCollectionDecorator' do
    assert @decorator.is_a?(ActiveRecordCollectionDecorator)
  end

  it 'item class is HouseholderDecorator' do
    assert_equal HouseholderDecorator, @decorator.item_decorator_class
  end

  it 'can get index url' do
    assert_equal '/territories/:tid/householders', @decorator.index_url
  end

  it 'can get new url' do
    assert_equal '/territories/:tid/householders/new', @decorator.new_url
  end

  it 'each yields item view' do
    collected = []

    @decorator.each do |item|
      collected << item
    end

    assert_same @item, collected.first.send(:item)
    assert collected.first.is_a?(HouseholderDecorator)
  end

  it '#territory return territory' do
    assert_same @territory, @decorator.territory
  end

  it '#territory raises when territory is not set' do
    error = assert_raises(StandardError) do
      HouseholdersDecorator.new(@item).territory
    end

    assert_equal 'territory was not set', error.message
  end

  it '#breadcrumbs returns correct collection' do
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.territories', '/territories'],
      ['T1', '/territories/:tid'],
      ['t.titles.householders']
    ]

    assert_equal expected, actual
  end
end
