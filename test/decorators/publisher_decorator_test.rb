require 'test_helper'

class PublisherDecoratorTest < TestCase
  def setup
    @item = stub(
      id: 1,
      to_param: 1,
      name: 'theName',
      email: 'theEmail',
      phone: 'thePhone'
    )

    @decorator = PublisherDecorator.new(@item).with_view_helpers(fake_view_helpers)
  end

  test 'extends BaseDecorator' do
    assert @decorator.is_a?(ActiveRecordModelDecorator)
  end

  test '#edit_url returns correct url' do
    assert_equal '/publishers/1/edit', @decorator.edit_url
  end

  test '#url returns correct url' do
    assert_equal '/publishers/1', @decorator.url
  end

  test '#index_url returns correct url' do
    assert_equal '/publishers', @decorator.index_url
  end

  test 'delegates name' do
    assert_delegates :name, @decorator, @item
  end

  test 'delegates email' do
    assert_delegates :email, @decorator, @item
  end

  test 'delegates phone' do
    assert_delegates :phone, @decorator, @item
  end

  test '#breadcrumbs for existing record' do
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.publishers', '/publishers'],
      ['theName']
    ]

    assert_equal expected, actual
  end

  test '#breadcrumbs for new record' do
    @item.stubs(id: nil)
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.publishers', '/publishers'],
      ['t.links.new']
    ]

    assert_equal expected, actual
  end
end
