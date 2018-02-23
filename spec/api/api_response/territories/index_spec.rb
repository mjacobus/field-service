require 'rails_helper'

RSpec.describe ApiResponse::Territories::Index do
  let(:territory) { Territory.new }
  let(:territories) { [ territory ] }

  subject { described_class.new(territories) }
  let(:data_hash) { subject.to_h[:data] }

  describe '#to_h' do
    it 'returns nil responsible when no one is assigned' do
      expect(data_hash.first[:responsible]).to be nil
    end

    it 'it returns responsible when someone is assigned' do
      territory.responsible = Publisher.new(id: 1, name: 'John')

      expect(data_hash.first[:responsible]).to eq(
        id: 1,
        name: 'John'
      )
    end
  end
end
