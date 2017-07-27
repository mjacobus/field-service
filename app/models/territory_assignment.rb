class TerritoryAssignment < ApplicationRecord
  belongs_to :territory
  belongs_to :publisher

  def returned?
    returned_at?
  end
end
