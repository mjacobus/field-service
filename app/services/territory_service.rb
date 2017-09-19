class TerritoryService
  def search(assigned_to_ids: nil, pending_return: nil)
    query = TerritoryQuery.new

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
    ids = TerritoryAssignment.select(:territory_id).where('assigned_at >= ?', from.to_date)
    new(where.not(id: ids))
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
