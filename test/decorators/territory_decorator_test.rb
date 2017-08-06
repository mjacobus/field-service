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

  it 'extends BaseDecorator' do
    assert @decorator.is_a?(ActiveRecordModelDecorator)
  end

  it '#edit_url returns correct url' do
    assert_equal '/territories/1/edit', @decorator.edit_url
  end

  it '#url returns correct url' do
    assert_equal '/territories/1', @decorator.url
  end

  it '#index_url returns correct url' do
    assert_equal '/territories', @decorator.index_url
  end

  it '#householders_url returns the correct url' do
    assert_equal '/territories/1/householders', @decorator.householders_url
  end

  it 'delegates uuid to the territory' do
    assert_equal 'theUuid', @decorator.uuid
  end

  it 'delegates name to the territory' do
    assert_equal 'theName', @decorator.name
  end

  it 'delegates description to the territory' do
    assert_equal 'theDescription', @decorator.description
  end

  it 'can get form object' do
    assert_equal @item, @decorator.form_object
  end

  it '#breadcrumbs returns correct collection for new record' do
    @item.stubs(id: nil)

    expected = [
      ['t.titles.territories', '/territories'],
      ['t.links.new']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end

  it '#breadcrumbs returns correct collection for new record' do
    @item.stubs(id: true)

    expected = [
      ['t.titles.territories', '/territories'],
      ['theName']
    ]

    actual = @decorator.breadcrumbs

    assert_equal expected, actual
  end

  it '#number_of_householders returns the number of householders' do
    @item = Territory.make!
    Householder.make!(territory: @item)
    Householder.make!(territory: @item)
    @decorator = TerritoryDecorator.new(@item)

    assert_equal 2, @decorator.number_of_householders
  end

  describe '#html_classes' do
    it 'returns "pending-return" if #need_to_be_returned? is true' do
      @item.stubs(need_to_be_returned?: true)

      assert_equal 'pending-return', @decorator.html_classes
    end

    it 'returns "" if #need_to_be_returned? is false' do
      @item.stubs(need_to_be_returned?: false)

      assert_equal '', @decorator.html_classes
    end
  end
end
