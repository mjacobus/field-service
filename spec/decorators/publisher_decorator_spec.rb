require 'rails_helper'

RSpec.describe PublisherDecorator do
  let(:fake_view_helpers) { FakeViewHelpers.new }

  before do
    @item = double(
      id: 1,
      to_param: 1,
      name: 'theName',
      email: 'theEmail',
      phone: 'thePhone'
    )

    @decorator = PublisherDecorator.new(@item).with_view_helpers(fake_view_helpers)
  end

  it 'extends BaseDecorator' do
    assert @decorator.is_a?(ActiveRecordModelDecorator)
  end

  it '#edit_url returns correct url' do
    assert_equal '/publishers/1/edit', @decorator.edit_url
  end

  it '#url returns correct url' do
    assert_equal '/publishers/1', @decorator.url
  end

  it '#index_url returns correct url' do
    assert_equal '/publishers', @decorator.index_url
  end

  it 'delegates name' do
    assert_delegates :name, @decorator, @item
  end

  it 'delegates email' do
    assert_delegates :email, @decorator, @item
  end

  it 'delegates phone' do
    assert_delegates :phone, @decorator, @item
  end

  it '#breadcrumbs for existing record' do
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.publishers', '/publishers'],
      ['theName']
    ]

    assert_equal expected, actual
  end

  it '#breadcrumbs for new record' do
    allow(@item).to receive(:id) { nil }

    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.publishers', '/publishers'],
      ['t.links.new']
    ]

    assert_equal expected, actual
  end

  it '#html_classes returns classes' do
    allow(@item).to receive(:congregation_member?) { nil }

    classes = @decorator.html_classes
    assert_equal 'disabled', classes

    allow(@item).to receive(:congregation_member?) { true }
    classes = @decorator.html_classes
    assert_nil classes
  end
end
