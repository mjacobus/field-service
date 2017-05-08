require 'test_helper'

class UniqueIdTest < TestCase
  test 'when no id is given in the constructor creates a new unique id' do
    SecureRandom.expects(:uuid).returns('foobar')

    assert_equal 'foobar', UniqueId.new.to_s
  end

  test 'when id is passed in the constructor uses that value as unique id' do
    string = UniqueId.new('foo').to_s

    assert_equal 'foo', string
  end

  test '#== returns true when values are the same' do
    assert_equal UniqueId.new('foo'), UniqueId.new('foo')
  end

  test '#== returns false when values are different' do
    assert_not_equal UniqueId.new('foo'), UniqueId.new('bar')
  end

  test 'it is immutable' do
    value = 'foo'

    id = UniqueId.new(value)

    value.upcase!

    assert_equal 'foo', id.to_s
  end
end
