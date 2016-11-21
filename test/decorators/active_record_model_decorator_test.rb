require "test_helper"

class ActiveRecordModelDecoratorTest < ActiveSupport::TestCase
  def setup
    @klass = Class.new(ActiveRecordModelDecorator) do
      def index_url
        '/resource_name'
      end
    end

    @item = stub(
      to_param: 1,
      persisted?: true,
      name: 'theName',
      description: 'theDescription',
    )

    @view = @klass.new(@item)
  end

  test "extends BaseDecorator" do
    assert @view.is_a?(::BaseDecorator)
  end

  test "#edit_url returns correct url" do
    assert_equal '/resource_name/1/edit', @view.edit_url
  end

  test "#new_url returns correct url" do
    assert_equal '/resource_name/new', @view.new_url
  end

  test "#url returns correct url" do
    assert_equal '/resource_name/1', @view.url
  end

  test "#index_url returns correct url" do
    assert_equal '/resource_name', @view.index_url
  end

  test "can get form object" do
    assert_equal @item, @view.form_object
  end

  test "#form_url returns correct form url" do
    assert_equal '/resource_name/1', @klass.new(@item).form_url
    assert_equal '/resource_name', @klass.new(stub(persisted?: false)).form_url
  end
end
