class TerritoryHouseholderMapMarker
  def initialize(householder)
    @householder = householder
    @asset_helper = AssetHelper.new
  end

  def geolocation
    {
      lat: householder.lat,
      lng: householder.lon,
      visit: householder.visit?,
      present: has_geolocation?
    }
  end

  def has_geolocation?
    householder.has_geolocation?
  end

  def title
    [householder.name, householder.address].join("\n")
  end

  def icon
    if householder.visit?
      return asset_helper.image_url('map_pin.png')
    end

    asset_helper.image_url('map_pin_do_not_visit.png')
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
