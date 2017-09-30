class ReturnTerritory
  def perform(territory_id:, complete:, returned_at: Date.today)
    unreturned = TerritoryAssignment.where(territory_id: territory_id, returned: false)

    unreturned.each do |territory|
      territory.returned = true
      territory.returned_at = returned_at
      territory.complete = complete
      territory.save!
    end
  end
end
