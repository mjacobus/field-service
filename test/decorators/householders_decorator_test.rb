require "test_helper"

class HouseholdersDecoratorTest < ActiveSupport::TestCase
  def setup
    @territory = stub(id: ':tid')
    @item = stub(id: 1)
    @collection = [@item]
    @view ||= HouseholdersDecorator.new(@collection, @territory)
  end

  test "is a ActiveRecordCollectionDecorator" do
    assert @view.is_a?(ActiveRecordCollectionDecorator)
  end

  test "item class is HouseholderDecorator" do
    assert_equal HouseholderDecorator, @view.item_decorator_class
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
    assert collected.first.is_a?(HouseholderDecorator)
  end

  test "#territory return territory" do
    assert_same @territory, @view.territory
  end

  test "#territory raises when territory is not set" do
    error = assert_raises(StandardError) do
      HouseholdersDecorator.new(@item).territory
    end

    assert_equal 'territory was not set', error.message
  end
end
