require 'rails_helper'

RSpec.describe ApiResponse::Territories::Show do
  subject { described_class.new(territory, user: user) }

  let(:territory) { Territory.new }
  let(:user) { User.new(admin: true) }
  let(:data_hash) { subject.to_h[:data] }

  before do
    allow_any_instance_of(ApiHelpers::UrlHelper).to receive(:territory_return_path)
      .with(territory) { '/return' }

    allow_any_instance_of(ApiHelpers::UrlHelper).to receive(:territory_assign_path)
      .with(territory) { '/assign' }

    allow_any_instance_of(ApiHelpers::UrlHelper).to receive(:edit_territory)
      .with(territory) { '/edit' }
  end

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
      territory.responsible = Publisher.new(name: 'John', id: 1)

      expect(data_hash[:responsible]).to eq(
        id: 1,
        name: 'John'
      )
    end
  end

  describe 'links' do
    describe 'when user is an admin' do
      it 'includes edit link when' do
        expect(data_hash[:links][:edit]).to eq('/edit')
      end

      it 'includes return link when territory is assigned' do
        allow(territory).to receive(:assigned?) { true }

        expect(data_hash[:links][:return]).to eq('/return')
      end

      it 'does not include return link when territory is assigned' do
        allow(territory).to receive(:assigned?) { false }

        expect(data_hash[:links][:return]).to be_nil
      end

      it 'includes assign link when territory is assigned' do
        allow(territory).to receive(:assigned?) { false }

        expect(data_hash[:links][:assign]).to eq('/assign')
      end

      it 'does not include assign link when territory is assigned' do
        allow(territory).to receive(:assigned?) { true }

        expect(data_hash[:links][:assign]).to be_nil
      end
    end

    describe 'when user is not an admin' do
      let(:user) { User.new(admin: false) }

      it 'does not includes edit link when' do
        expect(data_hash[:links][:edit]).to be_nil
      end

      it 'does not include return link when territory is assigned' do
        allow(territory).to receive(:assigned?) { true }

        expect(data_hash[:links][:return]).to be_nil
      end

      it 'does not include assign link when territory is assigned' do
        allow(territory).to receive(:assigned?) { false }

        expect(data_hash[:links][:assign]).to be_nil
      end
    end
  end
end
