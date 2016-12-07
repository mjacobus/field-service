require "test_helper"

class TerritoryDecoratorTest < ActiveSupport::TestCase
  def setup
    @item = stub(
      to_param: 1,
      name: 'theName',
      description: 'theDescription',
    )
    @view = TerritoryDecorator.new(@item)
  end

  test "extends BaseDecorator" do
    assert @view.is_a?(ActiveRecordModelDecorator)
  end

  test "#edit_url returns correct url" do
    assert_equal '/territories/1/edit', @view.edit_url
  end

  test "#url returns correct url" do
    assert_equal '/territories/1', @view.url
  end

  test "#index_url returns correct url" do
    assert_equal '/territories', @view.index_url
  end

  test "#householders_url returns the correct url" do
    assert_equal "/territories/1/householders", @view.householders_url
  end

  test "delegates name to the territory" do
    assert_equal 'theName', @view.name
  end

  test "delegates description to the territory" do
    assert_equal 'theDescription', @view.description
  end

  test "can get form object" do
    assert_equal @item, @view.form_object
  end
end
