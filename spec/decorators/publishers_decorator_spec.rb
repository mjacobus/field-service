require 'rails_helper'

RSpec.describe PublishersDecorator do
  let(:fake_view_helpers) { FakeViewHelpers.new }

  before do
    @item = double(id: 1)
    @collection = [@item]
    @decorator ||= PublishersDecorator.new(@collection).with_view_helpers(fake_view_helpers)
  end

  it 'is a ActiveRecordCollectionDecorator' do
    assert @decorator.is_a?(ActiveRecordCollectionDecorator)
  end

  it 'item class is PublisherDecorator' do
    assert_equal PublisherDecorator, @decorator.item_decorator_class
  end

  it 'can get index url' do
    assert_equal '/publishers', @decorator.index_url
  end

  it 'can get new url' do
    assert_equal '/publishers/new', @decorator.new_url
  end

  it 'each yields item view' do
    collected = []

    @decorator.each do |item|
      collected << item
    end

    assert_same @item, collected.first.send(:item)
    assert collected.first.is_a?(PublisherDecorator)
  end

  it '#breadcrumbs returns correct collection' do
    expected = [
      ['t.titles.publishers']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end
end
