require 'rails_helper'

RSpec.describe Api::ApiResponse::Territories::Show do
  let(:territory) { Territory.new }
  subject  { described_class.new(territory) }

  describe '#map_coordinates' do
    it 'is empty when none is saved' do
      expect(subject.to_h[:data][:map][:coordinates]).to eq []
    end

    it 'is empty when none is saved' do
      territory.map_coordinates = ['foo']

      expect(subject.to_h[:data][:map][:coordinates]).to eq ['foo']
    end
  end
end
