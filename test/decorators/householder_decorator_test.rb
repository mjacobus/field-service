require 'test_helper'

class HouseholderDecoratorTest < TestCase
  def setup
    @territory = stub(id: 4)
    @item = stub(
      id: 1,
      territory: stub(
        name: 'T1'
      ),
      to_param: 1,
      name: 'theName',
      notes: 'theNotes',
      uuid: 'theUuid',
      house_number: 'houseNumber',
      street_name: 'theStreet',
      do_not_visit_date?: false,
      show: true,
      territory_id: ':tid',
      description: 'theDescription'
    )

    @decorator = HouseholderDecorator.new(@item).with_view_helpers(fake_view_helpers)
  end

  test 'extends BaseDecorator' do
    assert @decorator.is_a?(ActiveRecordModelDecorator)
  end

  test '#edit_url returns correct url' do
    assert_equal '/territories/:tid/householders/1/edit', @decorator.edit_url
  end

  test '#url returns correct url' do
    assert_equal '/territories/:tid/householders/1', @decorator.url
  end

  test '#index_url returns correct url' do
    assert_equal '/territories/:tid/householders', @decorator.index_url
  end

  test 'delegates name' do
    assert_delegates :name, @decorator, @item
  end

  test 'delegates notes' do
    assert_delegates :notes, @decorator, @item
  end

  test 'delegates name' do
    assert_delegates :uuid, @decorator, @item
  end

  test 'delegates house_number' do
    assert_delegates :house_number, @decorator, @item
  end

  test 'delegates street_name' do
    assert_delegates :street_name, @decorator, @item
  end

  test 'delegates show' do
    assert_delegates :show, @decorator, @item
  end

  test 'delegates territory' do
    assert_delegates :territory, @decorator, @item
  end

  test '#html_classes returns empty when active' do
    assert_equal '', @decorator.html_classes.to_s
  end

  test "#html_classes returns 'disabled' when show is false" do
    @decorator = HouseholderDecorator.new(stub(show: true, do_not_visit_date?: true))

    assert_equal 'disabled', @decorator.html_classes.to_s
  end

  test "#html_classes returns 'do_not_visit_date?' is true" do
    @decorator = HouseholderDecorator.new(stub(show: true, do_not_visit_date?: true))

    assert_equal 'disabled', @decorator.html_classes.to_s
  end

  test '#breadcrumbs for existing record' do
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.territories', '/territories'],
      ['T1', '/territories/:tid'],
      ['t.titles.householders', '/territories/:tid/householders'],
      ['theStreet houseNumber (theName)']
    ]

    assert_equal expected, actual
  end

  test '#breadcrumbs for new record' do
    @item.stubs(id: nil)
    actual = @decorator.breadcrumbs

    expected = [
      ['t.titles.territories', '/territories'],
      ['T1', '/territories/:tid'],
      ['t.titles.householders', '/territories/:tid/householders'],
      ['t.links.new']
    ]

    assert_equal expected, actual
  end

  test '#show?' do
    @item.stubs(show?: true)

    assert_equal 't.yes', @decorator.show?

    @item.stubs(show?: false)

    assert_equal 't.no', @decorator.show?
  end

  test '#has_notes?' do
    @item.stubs(notes: 'some')

    assert @decorator.has_notes?

    @item.stubs(notes: '')

    assert !@decorator.has_notes?
  end
end
