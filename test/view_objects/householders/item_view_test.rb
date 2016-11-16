require "test_helper"

module Householders
  class ItemViewTest < ActiveSupport::TestCase
    def setup
      @item = stub(
        to_param: 1,
        name: 'theName',
        description: 'theDescription',
      )
      @view = ItemView.new(@item)
    end

    test "extends ViewObject" do
      assert @view.is_a?(::ViewObject)
    end

    test "#edit_url returns correct url" do
      assert_equal '/householders/1/edit', @view.edit_url
    end

    test "#url returns correct url" do
      assert_equal '/householders/1', @view.url
    end

    test "#index_url returns correct url" do
      assert_equal '/householders', @view.index_url
    end

    test "delegates name to the item" do
      assert_equal 'theName', @view.name
    end

    test "delegates description to the item" do
      assert_equal 'theDescription', @view.description
    end

    test "can get form object" do
      assert_equal @item, @view.form_object
    end
  end
end