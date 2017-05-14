class HouseholderImporter
  def import_batch(collection)
    ActiveRecord::Base.transaction do
      collection.each { |row| import(row) }
    end
  end

  def import(territory_name:, street_name:, house_number:, name:, show:, uuid: nil, updated_at: nil)
    show = ![false, 'no'].include?(show)

    householder = Householder.find_by_uuid(uuid)
    householder ||= Householder.new

    return if skip_update?(householder, updated_at)

    householder.attributes = {
      street_name: street_name,
      house_number: house_number,
      name: name,
      show: show,
      uuid: uuid || UniqueId.new,
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

  def parse_time(time)
    return time if time.is_a?(Time)
    Time.parse(time)
  end

  def territory_changed?(householder, territory_name)
    householder.territory_name.to_s.downcase != territory_name.downcase
  end

  def assign_territory_by_name(householder, territory_name)
    territory = Territory.find_by_name(territory_name)
    territory ||= Territory.create!(name: territory_name)

    householder.territory = territory
  end
end
