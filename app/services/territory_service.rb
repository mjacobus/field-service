class TerritoryService
  def search(assigned_to_ids: nil, pending_return: nil, inactive_from: nil)
    query = TerritoryQuery.new

    if inactive_from
      query = query.inactive(from: inactive_from)
    end

    if assigned_to_ids
      query = query.with_publisher_ids(assigned_to_ids)
    end

    if pending_return
      query = query.pending_return
    end

    query
  end

  def inactive(from:)
    TerritoryQuery.new.inactive(from: from)
  end

  def worked(from:)
    TerritoryQuery.new.worked(from: from)
  end
end

class TerritoryQuery < SimpleDelegator
  def initialize(scope = Territory.sorted)
    super(scope)
  end

  def with_publisher_ids(ids)
    new_scope = assigned.where(territory_assignments: { publisher_id: array_of_ints(ids) })
    new(new_scope)
  end

  def assigned
    new(joins(:assignments).where(territory_assignments: { returned_at: nil }))
  end

  def pending_return
    new_scope = assigned.where('return_date < :today_date', today_date: Date.today)
    new(new_scope)
  end

  def inactive(from:)
    worked_ids = worked(from: from).select(:id)
    limit_date = from.to_date
    assigned_after = TerritoryAssignment.where('assigned_at >= ?', limit_date)
    new(where.not(id: worked_ids).where.not(id: assigned_after.select(:territory_id)))
  end

  def worked(from:)
    limit_date = from.to_date
    worked_ids = TerritoryAssignment.where('returned_at >= ?', limit_date)
                                    .where.not(returned_at: nil).select(:territory_id)
    new(where(id: worked_ids))
  end

  private

  def new(scope)
    self.class.new(scope)
  end

  def scope
    __item__
  end

  def array_of_ints(items)
    items.map { |item| Integer(item) }
  end
end
