require "test_helper"

module Territories
  class CollectionViewTest < ActiveSupport::TestCase
    def setup
      @item = stub(id: 1)
      @collection = [@item]
      @subject ||= Territories::CollectionView.new(@collection)
    end

    test "can get index url" do
      assert_equal "/territories", @subject.index_url
    end

    test "can get new url" do
      assert_equal "/territories/new", @subject.new_url
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
