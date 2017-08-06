require 'test_helper'

class PublisherTest < ActiveSupport::TestCase
  it 'validates presence of #name' do
    item = Publisher.new
    refute item.valid?

    item.name = 'foo'
    assert item.valid?
  end

  it '#sorted by name' do
    b = Publisher.create!(name: 'Berry')
    a = Publisher.create!(name: 'Antony')

    assert_equal [a, b], Publisher.all.sorted
  end
end
