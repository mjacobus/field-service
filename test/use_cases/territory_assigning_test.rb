require 'test_helper'

class TerritoryAssigningTest < TestCase
  let(:publisher) { Publisher.make! }
  let(:territory) { Territory.make! }

  subject do
    TerritoryAssigning.new
  end

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

      assert_equal 1, TerritoryAssignment.count
      assert_equal publisher.id, TerritoryAssignment.last.publisher_id
      assert_equal territory.id, TerritoryAssignment.last.territory_id
    end

    it '#assignned_at defaults to current date' do
      assert_equal_objects Date.today, perform.assigned_at.to_date
    end

    it '#assignned_at can be set to something else' do
      time = perform(assigned_at: '2001-02-03').assigned_at

      assert_equal_objects Date.new(2001, 2, 3), time.to_date
    end

    it '#returned defaults to false' do
      refute perform.returned?
    end

    it '#return_date is 4 months after assigned_at' do
      date = perform.return_date.to_date

      assert_equal_objects 4.months.from_now.to_date, date
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

      refute other_territory_assignment.returned?
      assert old_assignment.returned?
      assert_equal_objects date.to_date, old_assignment.returned_at.to_date

      refute new_assignment.returned?
    end
  end
end
