class HouseholderImporter < BaseImporter
  def import(territory_name:, street_name:, house_number:, name:, show:, uuid: nil, updated_at: nil, do_not_visit_date: nil)
    show = ![false, 'no', 0, '0'].include?(show)

    householder = Householder.find_by_uuid(uuid)
    householder ||= Householder.new

    return if skip_update?(householder, updated_at)

    householder.attributes = {
      street_name: street_name,
      house_number: house_number,
      name: name,
      show: show,
      uuid: uuid || UniqueId.new,
      do_not_visit_date: parse_date(do_not_visit_date),
      updated_at: updated_at
    }

    if territory_changed?(householder, territory_name)
      assign_territory_by_name(householder, territory_name)
    end

    householder.save!
  end

  private

  def skip_update?(householder, updated_at)
    return false unless householder.updated_at
    persisted_updated_at = parse_time(householder.updated_at)
    updated_at = parse_time(updated_at)

    persisted_updated_at >= updated_at
  end

  def territory_changed?(householder, territory_name)
    !householder.territory_name.to_s.casecmp(territory_name.to_s.downcase).zero?
  end

  def assign_territory_by_name(householder, territory_name)
    territory = Territory.find_by_name(territory_name)
    territory ||= Territory.create!(name: territory_name)

    householder.territory = territory
  end
end
