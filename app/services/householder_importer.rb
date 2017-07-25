class HouseholderImporter
  ImportError = Class.new(RuntimeError)

  DATE_FORMATS = [
    # matcher, parser argument
    [/^(\d{1,2}\.){2}\d{2}$/, '%d.%m.%y']
  ].freeze

  def initialize(date_formats: DATE_FORMATS)
    @date_formats = date_formats
  end

  def import_batch(collection)
    ActiveRecord::Base.transaction do
      collection.each_with_index do |row, index|
        begin
          import(row)
        rescue Exception => e
          message = ['Line', index + 2, ':', e.message].join(' ')
          raise ImportError, message
        end
      end
    end
  end

  def import(territory_name:, street_name:, house_number:, name:, show:, uuid: nil, updated_at: nil, do_not_visit_date: nil)
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

  def parse_time(time)
    return time if time.is_a?(Time)
    Time.parse(time).utc
  end

  def parse_date(date)
    return date if date.is_a?(Date)

    if date.to_s == ''
      return nil
    end

    @date_formats.each do |format|
      if date =~ format.first
        return Date.strptime(date, format.last)
      end
    end

    Date.parse(date)
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
