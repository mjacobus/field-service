require 'rails_helper'

RSpec.describe TerritoryHouseholderMapMarkers do
  it 'deals with both markeres and householders' do
    h1 = Householder.new(name: 'foo')
    h2 = Householder.new(name: 'bar')

    initialized_with_mixed = described_class.new([h1, TerritoryHouseholderMapMarker.new(h2)])
    initialized_with_householders = described_class.new([h1, h2])

    expect(initialized_with_mixed).to be_equal_to(initialized_with_householders)
  end

  describe '#to_h' do
    it 'converts collection to array of hashes' do
      marker = instance_double(TerritoryHouseholderMapMarker)
      allow(marker).to receive(:is_a?).and_return(true)
      allow(marker).to receive(:to_h).and_return(foo: :bar)

      markers = described_class.new([marker])

      expect(markers.to_h).to eq [{ foo: :bar }]
    end
  end
end
