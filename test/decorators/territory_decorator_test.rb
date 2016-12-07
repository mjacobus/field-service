require "test_helper"

class TerritoryDecoratorTest < ActiveSupport::TestCase
  def setup
    @item = stub(
      to_param: 1,
      name: 'theName',
      description: 'theDescription',
    )
    @decorator = TerritoryDecorator.new(@item)
  end

  test "extends BaseDecorator" do
    assert @decorator.is_a?(ActiveRecordModelDecorator)
  end

  test "#edit_url returns correct url" do
    assert_equal '/territories/1/edit', @decorator.edit_url
  end

  test "#url returns correct url" do
    assert_equal '/territories/1', @decorator.url
  end

  test "#index_url returns correct url" do
    assert_equal '/territories', @decorator.index_url
  end

  test "#householders_url returns the correct url" do
    assert_equal "/territories/1/householders", @decorator.householders_url
  end

  test "delegates name to the territory" do
    assert_equal 'theName', @decorator.name
  end

  test "delegates description to the territory" do
    assert_equal 'theDescription', @decorator.description
  end

  test "can get form object" do
    assert_equal @item, @decorator.form_object
  end
end
