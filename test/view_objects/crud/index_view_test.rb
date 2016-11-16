require "test_helper"

module Crud
  class IndexViewTest < ActiveSupport::TestCase
    def setup
      klass = Class.new(Crud::IndexView) do
        def index_url
          '/resource_name'
        end
      end

      @item = stub(id: 1)
      @collection = [@item]
      @view ||= klass.new(@collection)
    end

    test "extends ViewObject" do
      assert @view.is_a?(ViewObject)
    end

    test "can get index url" do
      assert_equal "/resource_name", @view.index_url
    end

    test "can get new url" do
      assert_equal "/resource_name/new", @view.new_url
    end

    # test "each yields item view" do
    #   collected = []
    #
    #   @view.each do |item|
    #     collected << item
    #   end
    #
    #   assert_same @item, collected.first.send(:item)
    #   assert collected.first.is_a?(ItemView)
    # end
  end
end
