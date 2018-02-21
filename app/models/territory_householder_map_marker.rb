class TerritoryHouseholderMapMarker
  def initialize(householder)
    @householder = householder
    @asset_helper = AssetHelper.new
  end

  def geolocation
    { lat: householder.lat, lng: householder.lon, present: householder.has_geolocation? }
  end

  def title
    [householder.name, householder.address].join("\n")
  end

  def icon
    @asset_helper.image_url('map_pin.png')
  end

  def to_h
    {
      icon: icon,
      geolocation: geolocation,
      title: title
    }
  end

  private

  attr_reader :householder
  attr_reader :asset_helper
end
