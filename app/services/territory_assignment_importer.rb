class TerritoryAssignmentImporter < BaseImporter
  TerritoryNotFoundError = Class.new(RuntimeError)
  InvalidDateError = Class.new(RuntimeError)

  # :reek:TooManyStatements
  # :reek:LongParameterList
  def import(territory_name:, publisher_name:, assigned_at:, returned_at: nil)
    territory = Territory.find_by_name(territory_name)

    unless territory
      raise(TerritoryNotFoundError, "Territory '#{territory_name}' not found")
    end

    publisher = Publisher.find_or_create_by!(
      name: publisher_name
    )

    assigned_at = parse_date(assigned_at)

    unless assigned_at
      raise(InvalidDateError, "Invalid date: '#{assigned_at}'")
    end

    TerritoryAssigning.new.perform(
      territory_id: territory.id,
      publisher_id: publisher.id,
      assigned_at: assigned_at
    )

    returned_at = parse_date(returned_at)

    if returned_at
      ReturnTerritory.new.perform(territory_id: territory.id, returned_at: returned_at)
    end
  end
end
