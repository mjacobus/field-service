require 'spec_helper'

RSpec.describe GeolocationService do
  describe '#center_of' do
    let(:center) { subject.center_of(locations) }

    describe 'when there are two or more geolocations' do
      let(:locations) do
        [
          { 'lat' => -10, 'lng' => 2 },
          { lat: -2, 'lng' => 3 },
          { 'lat' => 4, 'lng' => 8 }
        ]
      end

      it 'returns the average' do
        expect(center).to eq(lat: -3, lng: 5, present: true)
      end
    end

    describe 'when there is one geolocation' do
      let(:locations) { [{ 'lat' => -10, 'lng' => 2 }] }

      it 'returns that geolocation' do
        expect(center).to eq(lat: -10, lng: 2, present: true)
      end
    end

    describe 'when there is no geolocation' do
      let(:locations) { [] }

      it 'returns that nil with present false' do
        expect(center).to eq(lat: nil, lng: nil, present: false)
      end
    end
  end
end
