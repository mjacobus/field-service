require 'rails_helper'

RSpec.describe ApiResponse::Territories::Show do
  let(:territory) { Territory.new }
  subject  { described_class.new(territory) }
  let(:data_hash) { subject.to_h[:data] }

  describe '#to_h' do
    it 'returns empty coordinates when not present' do
      expect(data_hash[:map][:coordinates]).to eq []
    end

    it 'returns the coordinates when present' do
      territory.map_coordinates = [{ 'foo' => 'bar' }]

      expect(data_hash[:map][:coordinates]).to eq [{ 'foo' => 'bar' }]
    end

    it 'returns null #responsible when non one is assigned' do
      expect(data_hash[:responsible]).to be_nil
    end

    it 'returns responsible name #responsible when one is assigned' do
      territory.responsible = Publisher.new(name: 'John')

      expect(data_hash[:responsible]).to eq 'John'
    end
  end
end
