require 'rails_helper'

RSpec.describe TerritoryMap do
  let(:coordinates) do
    [{ 'lat' => 1, 'lng' => 2 }, { 'lat' => 1, 'lng' => 2 }]
  end

  let(:map) { TerritoryMap.new(coordinates: coordinates) }

  describe '#coordinates' do
    it 'has coordinates' do
      map = TerritoryMap.new(coordinates: coordinates)

      expect(map.coordinates).to eq(coordinates)
    end

    it 'returns empty array when nil is given' do
      map = TerritoryMap.new(coordinates: nil)

      expect(map.coordinates).to eq []
    end
  end

  describe '#center' do
    let(:coordinates) do
      [
        { 'lat' => -10, 'lng' => 2 },
        { 'lat' => -2,  'lng' => 3 },
        { 'lat' => 4,   'lng' => 8 }
      ]
    end

    it 'returns the center of all the combinations' do
      expect(map.center[:lat]).to eq -3
      expect(map.center[:lng]).to eq 5
    end
  end

  describe '#to_h' do
    it 'converts to hash' do
      expected_hash = {
        coordinates: coordinates,
        center: { lat: 1, lng: 2 }
      }

      expect(map.to_h).to eq expected_hash
    end
  end
end
