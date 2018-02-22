require 'rails_helper'

RSpec.describe Api::ApiResponse::Territories::Show do
  let(:territory) { Territory.new }
  subject  { described_class.new(territory) }

  describe '#to_h' do
    it 'returns empty coordinates when not present' do
      expect(subject.to_h[:data][:map][:coordinates]).to eq []
    end

    it 'returns the coordinates when present' do
      territory.map_coordinates = [{ 'foo' => 'bar' }]

      expect(subject.to_h[:data][:map][:coordinates]).to eq [{ 'foo' => 'bar' }]
    end
  end
end
