class Householder < ApplicationRecord
  belongs_to :territory

  validates :name, presence: true
  validates :uuid, presence: true, uniqueness: { case_sensitive: false }
  validates :street_name, presence: true
  validates :house_number, presence: true

  default_scope -> { sorted }
  scope :sorted, -> { order(:street_name, :house_number_as_int, :house_number) }

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

  def update_geolocation
    address = [street_name, house_number].join(' ')

    data = Koine::GoogleMapsClient.new.geocode(address: address)

    result = data['results'].first

    return unless result

    location = result['geometry']['location']
    self.lat =  location['lat']
    self.lon =  location['lng']
  end

  def to_s
    "#{street_name} #{house_number} (#{name})"
  end

  def has_geolocation?
    [lat, lon].compact.length == 2
  end

  def house_number=(number)
    super(number)
    self.house_number_as_int = number.to_i
  end
end
