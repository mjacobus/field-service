require "test_helper"

module Territories
  class CollectionViewTest < ActiveSupport::TestCase
    def setup
      @item = stub(id: 1)
      @collection = [@item]
      @view ||= Territories::CollectionView.new(@collection)
    end

    test "is a Crud::IndexDecorator" do
      assert @view.is_a?(Crud::IndexDecorator)
    end

    test "item class is ItemView" do
      assert_equal ItemView, @view.item_decorator_class
    end

    test "can get index url" do
      assert_equal "/territories", @view.index_url
    end

    test "can get new url" do
      assert_equal "/territories/new", @view.new_url
    end

    test "each yields item view" do
      collected = []

      @view.each do |item|
        collected << item
      end

      assert_same @item, collected.first.send(:item)
      assert collected.first.is_a?(ItemView)
    end
  end
end
