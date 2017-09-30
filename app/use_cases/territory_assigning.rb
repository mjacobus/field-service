class TerritoryAssigning
  def perform(territory_id:, publisher_id:, assigned_at: Date.today)
    ReturnTerritory.new.perform(territory_id: territory_id, returned_at: assigned_at, complete: nil)

    assignment = TerritoryAssignment.new(
      territory_id: territory_id,
      publisher_id: publisher_id,
      assigned_at: assigned_at
    )

    assignment.return_date = (assignment.assigned_at + 4.months)
    assignment.save!
    assignment
  end
end
