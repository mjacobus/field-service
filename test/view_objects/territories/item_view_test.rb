require "test_helper"

module Territories
  class ItemViewTest < ActiveSupport::TestCase
    def setup
      @territory = stub(
        to_param: 1,
        name: 'theName',
        description: 'theDescription',
      )
      @view = ItemView.new(@territory)
    end

    test "extends ViewObject" do
      assert @view.is_a?(::ViewObject)
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

    test "delegates name to the territory" do
      assert_equal 'theName', @view.name
    end

    test "delegates description to the territory" do
      assert_equal 'theDescription', @view.description
    end

    test "can get form object" do
      assert_equal @territory, @view.form_object
    end
  end
end
