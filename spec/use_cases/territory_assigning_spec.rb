require 'rails_helper'

RSpec.describe TerritoryAssigning do
  let(:publisher) { Publisher.make! }
  let(:territory) { Territory.make! }

  subject { TerritoryAssigning.new }

  def perform(attributes = {})
    subject.perform(
      {
        territory_id: territory.id,
        publisher_id: publisher.id
      }.merge(attributes)
    )
  end

  describe '#perform' do
    it 'can assign territory to publisher' do
      perform

      expect(TerritoryAssignment.count).to eq 1
      expect(TerritoryAssignment.last.publisher_id).to eq publisher.id
      expect(TerritoryAssignment.last.territory_id).to eq territory.id
    end

    it '#assignned_at defaults to current date' do
      expect(perform.assigned_at).to eq Date.today
    end

    it '#assignned_at can be set to something else' do
      time = perform(assigned_at: '2001-02-03').assigned_at

      expect(time.to_date).to eq Date.new(2001, 2, 3)
    end

    it '#returned defaults to false' do
      expect(perform).not_to be_returned
    end

    it '#return_date is 4 months after assigned_at' do
      date = perform.return_date.to_date

      expect(4.months.from_now.to_date).to eq date
    end

    it 'sets unreturned territories to returned' do
      date = 7.days.ago

      other_territory_assignment = perform(
        territory_id: Territory.make!.id,
        publisher_id: Publisher.make!.id
      )

      old_assignment = perform

      new_assignment = perform(assigned_at: date)

      other_territory_assignment.reload
      old_assignment.reload

      expect(other_territory_assignment).not_to be_returned
      expect(old_assignment).to be_returned

      expect(old_assignment.returned_at.to_date).to eq(date.to_date)

      expect(new_assignment).not_to be_returned
    end
  end
end
