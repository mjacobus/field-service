require "test_helper"

module Householders
  class CollectionViewTest < ActiveSupport::TestCase
    def setup
      @item = stub(id: 1)
      @collection = [@item]
      @subject ||= Householders::CollectionView.new(@collection)
    end

    test "can get index url" do
      assert_equal "/householders", @subject.index_url
    end

    test "can get new url" do
      assert_equal "/householders/new", @subject.new_url
    end

    test "each yields item view" do
      collected = []

      @subject.each do |item|
        collected << item
      end

      assert_same @item, collected.first.send(:item)
      assert collected.first.is_a?(ItemView)
    end
  end
end
