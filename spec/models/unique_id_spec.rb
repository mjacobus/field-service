require 'spec_helper'

RSpec.describe UniqueId do
  it 'when no id is given in the constructor creates a new unique id' do
    expect(SecureRandom).to receive(:uuid) { 'foobar' }

    expect(UniqueId.new.to_s).to eq 'foobar'
  end

  it 'when id is passed in the constructor uses that value as unique id' do
    string = UniqueId.new('foo').to_s

    expect(string).to eq 'foo'
  end

  it '#== returns true when values are the same' do
    expect(UniqueId.new('foo')).to eq UniqueId.new('foo')
  end

  it '#== returns false when values are different' do
    expect(UniqueId.new('bar')).not_to eq UniqueId.new('foo')
  end

  it 'it is immutable' do
    value = 'foo'

    id = UniqueId.new(value)

    value.upcase!

    expect(id.to_s). to eq 'foo'
  end
end
