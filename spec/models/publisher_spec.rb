require 'rails_helper'

describe Publisher do
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

  it 'cannot be removed if has assignment' do
    publisher = TerritoryAssignment.make!.publisher

    expect do
      publisher.destroy
    end.to raise_error(DomainError, 'Cannot delete publisher')
  end

  it 'cannot be removed if has assignment' do
    Publisher.make!.destroy

    expect(Publisher.count).to eq(0)
  end
end
