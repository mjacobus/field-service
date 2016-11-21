require "test_helper"

module Householders
  class CollectionViewTest < ActiveSupport::TestCase
    def setup
      @territory = stub(id: ':tid')
      @item = stub(id: 1)
      @collection = [@item]
      @view ||= Householders::CollectionView.new(@collection, @territory)
    end

    test "is a ActiveRecordCollectionDecorator" do
      assert @view.is_a?(ActiveRecordCollectionDecorator)
    end

    test "item class is ItemView" do
      assert_equal ItemView, @view.item_decorator_class
    end

    test "can get index url" do
      assert_equal "/territories/:tid/householders", @view.index_url
    end

    test "can get new url" do
      assert_equal "/territories/:tid/householders/new", @view.new_url
    end

    test "each yields item view" do
      collected = []

      @view.each do |item|
        collected << item
      end

      assert_same @item, collected.first.send(:item)
      assert collected.first.is_a?(ItemView)
    end

    test "#territory return territory" do
      assert_same @territory, @view.territory
    end

    test "#territory raises when territory is not set" do
      error = assert_raises(StandardError) do
        CollectionView.new(@item).territory
      end

      assert_equal 'territory was not set', error.message
    end
  end
end
