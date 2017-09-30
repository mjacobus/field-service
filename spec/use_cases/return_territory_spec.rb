require 'rails_helper'

RSpec.describe ReturnTerritory do
  let(:publisher) { Publisher.make! }
  let(:territory) { Territory.make! }
  let(:assignment1) { TerritoryAssignment.make!(territory: territory) }
  let(:assignment2) { TerritoryAssignment.make!(territory: territory) }
  let(:assignment3) { TerritoryAssignment.make!(territory: territory) }
  let(:other_assignment) { TerritoryAssignment.make! }

  before do
    assignment1
    assignment2
    assignment3
  end

  def perform(attributes = {})
    params = { territory_id: territory.id }.merge(attributes)
    ReturnTerritory.new.perform(params).tap do
      assignment1.reload
      assignment2.reload
      assignment3.reload
      other_assignment.reload
    end
  end

  describe '#perform' do
    it 'marks all as returned' do
      returned_date = Date.today

      perform(complete: true)

      expect(assignment1.returned?).to be true
      expect(assignment2.returned?).to be true
      expect(assignment3.returned?).to be true

      expect(assignment1.complete?).to be true
      expect(assignment2.complete?).to be true
      expect(assignment3.complete?).to be true

      expect(returned_date).to be_equal_to(assignment1.returned_at)
      expect(returned_date).to be_equal_to(assignment2.returned_at)
      expect(returned_date).to be_equal_to(assignment3.returned_at)
    end

    it 'marks all as returned with custom date' do
      returned_date = 4.days.ago.to_date

      perform(returned_at: returned_date, complete: true)

      expect(assignment1.returned?).to be true
      expect(assignment2.returned?).to be true
      expect(assignment3.returned?).to be true

      expect(returned_date).to be_equal_to(assignment1.returned_at)
      expect(returned_date).to be_equal_to(assignment2.returned_at)
      expect(returned_date).to be_equal_to(assignment3.returned_at)
    end
  end
end
