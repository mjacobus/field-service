require 'test_helper'

class TerritoryDecoratorTest < TestCase
  def setup
    @item = stub(
      to_param: 1,
      uuid: 'theUuid',
      name: 'theName',
      description: 'theDescription'
    )
    @decorator = TerritoryDecorator.new(@item).with_view_helpers(fake_view_helpers)
  end

  test 'extends BaseDecorator' do
    assert @decorator.is_a?(ActiveRecordModelDecorator)
  end

  test '#edit_url returns correct url' do
    assert_equal '/territories/1/edit', @decorator.edit_url
  end

  test '#url returns correct url' do
    assert_equal '/territories/1', @decorator.url
  end

  test '#index_url returns correct url' do
    assert_equal '/territories', @decorator.index_url
  end

  test '#householders_url returns the correct url' do
    assert_equal '/territories/1/householders', @decorator.householders_url
  end

  test 'delegates uuid to the territory' do
    assert_equal 'theUuid', @decorator.uuid
  end

  test 'delegates name to the territory' do
    assert_equal 'theName', @decorator.name
  end

  test 'delegates description to the territory' do
    assert_equal 'theDescription', @decorator.description
  end

  test 'can get form object' do
    assert_equal @item, @decorator.form_object
  end

  test '#breadcrumbs returns correct collection for new record' do
    @item.stubs(id: nil)

    expected = [
      ['t.titles.territories', '/territories'],
      ['t.links.new']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end

  test '#breadcrumbs returns correct collection for new record' do
    @item.stubs(id: true)

    expected = [
      ['t.titles.territories', '/territories'],
      ['theName']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end

  test '#number_of_householders returns the number of householders' do
    @item = Territory.make!
    Householder.make!(territory: @item)
    Householder.make!(territory: @item)
    @decorator = TerritoryDecorator.new(@item)

    assert_equal 2, @decorator.number_of_householders
  end
end
