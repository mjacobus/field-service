require "test_helper"

module Householders
  class CollectionViewTest < ActiveSupport::TestCase
    def setup
      @item = stub(id: 1)
      @collection = [@item]
      @view ||= Householders::CollectionView.new(@collection)
    end

    test "is a Crud::IndexView" do
      assert @view.is_a?(Crud::IndexView)
    end

    test "item class is ItemView" do
      assert_equal ItemView, @view.item_class
    end

    test "can get index url" do
      assert_equal "/householders", @view.index_url
    end

    test "can get new url" do
      assert_equal "/householders/new", @view.new_url
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
