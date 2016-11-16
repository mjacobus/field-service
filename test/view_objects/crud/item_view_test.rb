require "test_helper"

module Crud
  class ItemViewTest < ActiveSupport::TestCase
    def setup
      klass = Class.new(ItemView) do
        def index_url
          '/resource_name'
        end
      end

      @item = stub(
        to_param: 1,
        name: 'theName',
        description: 'theDescription',
      )

      @view = klass.new(@item)
    end

    test "extends ViewObject" do
      assert @view.is_a?(::ViewObject)
    end

    test "#edit_url returns correct url" do
      assert_equal '/resource_name/1/edit', @view.edit_url
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
  end
end
