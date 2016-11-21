require "test_helper"

class DummyItemDecoratorClass
  attr_accessor :view_helpers, :item

  def initialize(item)
    @item = item
  end

  def with_view_helpers(view_helpers)
    @view_helpers = view_helpers
    self
  end
end

module Crud
  class IndexViewTest < ActiveSupport::TestCase

    def setup
      klass = Class.new(Crud::IndexView) do
        def index_url
          '/resource_name'
        end

        def item_decorator_class
          DummyItemDecoratorClass
        end
      end

      @item = stub(id: 1)
      @collection = [@item]
      @view ||= klass.new(@collection)
    end

    test "extends BaseDecorator" do
      assert @view.is_a?(BaseDecorator)
    end

    test "can get index url" do
      assert_equal "/resource_name", @view.index_url
    end

    test "can get new url" do
      assert_equal "/resource_name/new", @view.new_url
    end

    test "index_url must be implemented" do
      subject = IndexView.new([])

      assert_raises(BaseDecorator::MethodNotImplemented) do
        subject.index_url
      end
    end

    test "item_decorator_class must be implemented" do
      subject = IndexView.new([])

      exception = assert_raises(BaseDecorator::MethodNotImplemented) do
        subject.item_decorator_class
      end
    end

    test "each yields item view" do
      view_helpers = stub(:helpers)

      @view.with_view_helpers(view_helpers)
      collected = []

      @view.each do |item|
        collected << item
      end

      decorated_item = collected.first

      assert_same @item, decorated_item.item
      assert decorated_item.is_a?(DummyItemDecoratorClass), "Is actually a #{collected.first.class}"
      assert_same view_helpers, decorated_item.view_helpers
    end
  end
end
