# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiResponse::Territories::Index do
  let(:urls) { ApiHelpers::UrlHelper.new }
  let(:territory) { Territory.new }
  let(:territories) { [territory] }
  let(:user) { instance_double(User, admin?: admin) }
  let(:admin) { true }

  subject { described_class.new(territories, user: user) }
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

  describe 'data.links.new' do
    let(:links) { subject.to_h[:links] }

    context 'when user is an admin' do
      it 'returns the link' do
        expect(links[:newTerritory]).to eq(urls.new_territory_url)
      end
    end

    context 'when user is NOT an admin' do
      let(:admin) { false }

      it 'returns the link' do
        expect(links[:newTerritory]).to be_nil
      end
    end
  end
end
