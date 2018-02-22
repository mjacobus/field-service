require 'rails_helper'

RSpec.describe TerritoryHouseholderMapMarker do
  let(:householder) { Householder.new }
  let(:marker) { described_class.new(householder) }
  let(:hash) { marker.to_h }

  describe '#geolocation' do
    it 'returns the geolocation hash when present' do
      householder.show = true
      householder.lat = 1
      householder.lon = 2

      expect(marker.geolocation).to eq(lat: 1.0, lng: 2.0, present: true, visit: true)
    end

    it 'returns empty values when not present' do
      householder.lat = nil
      householder.lon = nil

      expect(marker.geolocation).to eq(lat: nil, lng: nil, present: false, visit: false)
    end
  end

  describe '#to_h' do
    it 'returns geolocation' do
      householder.lat = 1
      householder.lon = 2

      expect(hash[:geolocation][:lat]).to eq 1
      expect(hash[:geolocation][:lng]).to eq 2
      expect(hash[:geolocation][:present]).to be true
    end

    it 'returns title' do
      householder.name = 'John Doe'
      householder.street_name = 'Street'
      householder.house_number = '#num'

      expect(hash[:title]).to eq "John Doe\nStreet #num"
    end

    it 'returns pin icon when householder should be visited' do
      expect(hash[:icon]).to match(/map_pin.*.png/)
    end

    it 'returns do_not_visit pin icon when householder should not be visited' do
      householder.show = false

      expect(hash[:icon]).to match(/map_pin_do_not_visit.*.png/)
    end
  end
end
