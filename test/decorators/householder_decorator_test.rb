require "test_helper"

class HouseholderDecoratorTest < ActiveSupport::TestCase
  def setup
    @territory = stub(id: 4)
    @item = stub(
      to_param: 1,
      name: 'theName',
      house_number: 'houseNumber',
      street_name: 'theStreet',
      show: true,
      territory: 'theTerritory',
      territory_id: ':tid',
      description: 'theDescription',
    )
    @view = HouseholderDecorator.new(@item)
  end

  test "extends BaseDecorator" do
    assert @view.is_a?(ActiveRecordModelDecorator)
  end

  test "#edit_url returns correct url" do
    assert_equal '/territories/:tid/householders/1/edit', @view.edit_url
  end

  test "#url returns correct url" do
    assert_equal '/territories/:tid/householders/1', @view.url
  end

  test "#index_url returns correct url" do
    assert_equal '/territories/:tid/householders', @view.index_url
  end

  test "delegates name" do
    assert_delegates :name, @view, @item
  end

  test "delegates house_number" do
    assert_delegates :house_number, @view, @item
  end

  test "delegates street_name" do
    assert_delegates :street_name, @view, @item
  end

  test "delegates show" do
    assert_delegates :show, @view, @item
  end

  test "delegates territory" do
    assert_delegates :territory, @view, @item
  end
end
