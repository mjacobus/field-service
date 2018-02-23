require 'rails_helper'

RSpec.describe ApiResponse::Territories::Index do
  let(:territories) do
    [
      Territory.new,
      Territory.new,
    ]
  end

  subject { described_class.new(territories) }
  let(:data_hash) { subject.to_h[:data] }

  describe '#to_h' do
    it 'returns the correct fields' do
      expected_keys = [
        :id, 
        :slug, 
        :name, 
        :city, 
        :description, 
        :householders, 
        :currentAssignment, 
        :responsible
      ]

      data_hash.each do |hash_territory|
        expect(hash_territory.keys).to eq(expected_keys)
      end
    end
  end
end
