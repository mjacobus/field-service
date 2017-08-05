class TerritoryAssignment < ApplicationRecord
  belongs_to :territory
  belongs_to :publisher

  def returned?
    returned_at?
  end

  def pending_return?
    return false if returned?
    return false unless return_date < Date.today
    true
  end
end
