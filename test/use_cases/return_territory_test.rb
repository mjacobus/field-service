require 'test_helper'

class ReturnTerritoryTest < TestCase
  let(:publisher) { Publisher.make! }
  let(:territory) { Territory.make! }
  let(:assignment1) { TerritoryAssignment.make!(territory: territory) }
  let(:assignment2) { TerritoryAssignment.make!(territory: territory) }
  let(:assignment3) { TerritoryAssignment.make!(territory: territory) }
  let(:other_assignment) { TerritoryAssignment.make! }

  def setup
    assignment1
    assignment2
    assignment3
  end

  def perform(attributes = {})
    params = { territory_id: territory.id }.merge(attributes)
    ReturnTerritory.new.perform(params).tap do |_s|
      assignment1.reload
      assignment2.reload
      assignment3.reload
      other_assignment.reload
    end
  end

  describe '#perform' do
    it 'marks all as returned' do
      returned_date = Date.today

      perform

      assignment1.returned?.must_equal(true)
      assignment2.returned?.must_equal(true)
      assignment3.returned?.must_equal(true)

      assert_equal_objects(returned_date, assignment1.returned_at)
      assert_equal_objects(returned_date, assignment2.returned_at)
      assert_equal_objects(returned_date, assignment3.returned_at)
    end

    it 'marks all as returned with custom date' do
      returned_date = 4.days.ago.to_date

      perform(returned_at: returned_date)

      assignment1.returned?.must_equal(true)
      assignment2.returned?.must_equal(true)
      assignment3.returned?.must_equal(true)

      assert_equal_objects(returned_date, assignment1.returned_at)
      assert_equal_objects(returned_date, assignment2.returned_at)
      assert_equal_objects(returned_date, assignment3.returned_at)
    end
  end
end
