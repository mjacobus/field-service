# frozen_string_literal: true

class Householder < ApplicationRecord
  belongs_to :territory

  validates :name, presence: true
  validates :uuid, presence: true, uniqueness: { case_sensitive: false }
  validates :street_name, presence: true
  validates :house_number, presence: true

  default_scope -> { sorted }
  scope :sorted, -> { order(:normalized_street_name, :house_number_as_int, :house_number) }

  def initialize(*attrs)
    super
    self.uuid ||= UniqueId.new
  end

  def territory_name
    return nil unless territory
    territory.name
  end

  def self.ordered
    joins(:territory).order('territories.name', :street_name, :house_number)
  end

  def self.search(search_term)
    query = Householder.limit(100)
    normalizer = StreetNameNormalizer.new

    search_term.split(' ').each do |part|
      matcher = normalizer.normalize(part)
      query = query.where(
        'CONCAT(name, normalized_street_name) LIKE ?',
        "%#{matcher}%"
      )
    end

    query
  end

  def update_geolocation
    data = Koine::GoogleMapsClient.new.geocode(address: address_for_geolocation)

    if data['results'].empty?
      self.lat = nil
      self.lon = nil
      return
    end

    result = data['results'].first

    location = result['geometry']['location']
    self.lat =  location['lat']
    self.lon =  location['lng']
  end

  def to_s
    "#{address} (#{name})"
  end

  def has_geolocation?
    [lat, lon].compact.length == 2
  end

  def house_number=(number)
    super(number)
    self.house_number_as_int = number.to_i
  end

  def street_name=(street_name)
    super(street_name)
    self.normalized_street_name = street_normalizer.normalize(street_name).to_s
  end

  def address
    "#{normalized_street_name} #{house_number}"
  end

  def address_for_geolocation
    "#{address}, #{city_name}"
  end

  def has_notes?
    notes.present?
  end

  def visit?
    return false unless show
    !do_not_visit_date?
  end

  def city_name
    territory.city
  end

  private

  def street_normalizer
    @street_normalizer ||= StreetNameNormalizer.new
  end
end
