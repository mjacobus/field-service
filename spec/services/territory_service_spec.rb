require 'rails_helper'

RSpec.describe TerritoryService do
  let(:territory1) { Territory.make! }
  let(:territory2) { Territory.make! }
  let(:territory3) { Territory.make! }

  let(:publisher1) { Publisher.make! }
  let(:publisher2) { Publisher.make! }

  describe '#search' do
    describe 'with no parameters' do
      before do
        territory1
      end

      it 'returns all records' do
        results = TerritoryService.new.search

        expect(results.count).to eq(1)
        expect(results.to_a).to eq([territory1])
      end
    end

    describe 'with assigned_to_ids' do
      before do
        TerritoryAssigning.new.perform(
          territory_id: territory1.id,
          publisher_id: publisher1.id
        )

        TerritoryAssigning.new.perform(
          territory_id: territory1.id,
          publisher_id: publisher2.id
        )

        TerritoryAssigning.new.perform(
          territory_id: territory2.id,
          publisher_id: publisher2.id
        )

        TerritoryAssigning.new.perform(
          territory_id: territory3.id,
          publisher_id: publisher1.id
        )
      end

      it 'returns only the territories assigned to the given ids' do
        results = TerritoryService.new.search(assigned_to_ids: [publisher1.id])

        expect(results.count).to eq(1)
        expect(results.to_a).to eq([territory3])
      end
    end

    describe 'with pending return' do
      before do
        TerritoryAssigning.new.perform(
          territory_id: territory1.id,
          publisher_id: publisher1.id,
          assigned_at: Date.today
        )

        TerritoryAssigning.new.perform(
          territory_id: territory2.id,
          publisher_id: publisher1.id,
          assigned_at: 7.months.ago.to_date
        )

        TerritoryAssigning.new.perform(
          territory_id: territory3.id,
          publisher_id: publisher1.id,
          assigned_at: 7.months.ago.to_date
        )

        ReturnTerritory.new.perform(territory_id: territory3.id)
      end

      it 'returns only the ones with pending return' do
        results = TerritoryService.new.search(pending_return: '1')

        expect(results.count).to eq(1)
        expect(results.to_a).to eq([territory2])
      end
    end
  end
end
