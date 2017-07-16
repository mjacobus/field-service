require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  test "validates presence of #name" do
    item = Publisher.new
    refute item.valid?

    item.name = 'foo'
    assert item.valid?
  end
end
