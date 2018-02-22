require 'addressable/template'

module GoogleMapsHelper
  def google_maps
    @_google_maps ||= GoogleMapsHelperObject.new(self, static_api_key: ENV.to_h.fetch('GOOGLE_MAPS_STATIC_API_KEY'))
  end

  class GoogleMapsHelperObject
    JS_URL = 'https://maps.googleapis.com/maps/api/js'.freeze
    STATIC_MAP_URL = 'https://maps.google.com/maps/api/staticmap'.freeze
    KEY = 'AIzaSyCMFbHjf-I2rApFaatnmukLyfb1VIB8Jhk'.freeze

    attr_reader :context

    def initialize(context, config)
      @context = context
      @static_api_key = config.fetch(:static_api_key)
    end

    def js_source(params = {})
      authorized_url(JS_URL, params).to_s
    end

    def image_url(territory, _query_params = {})
      map = territory.map
      center = location_to_param(map.center)

      params = {
        center: center,
        size: '640x640', # max for free usage
        zoom: '14'
      }

      other_params = []

      other_params += static_markers(map)
      other_params += [borders(map)]

      url = url_for(STATIC_MAP_URL, params.merge(key: @static_api_key)).to_s
      "#{url}&#{other_params.join('&')}"
    end

    private

    def static_markers(map)
      map.markers.with_geolocation.map do |marker|
        marker_location = marker.geolocation
        geolocation = location_to_param(marker_location)
        color = marker_location[:visit] ? 'red' : 'white'
        "markers=color:#{color}|#{geolocation}"
      end
    end

    def borders(map)
      # path=color:0xff0000ff|weight:2|40.737102,-73.990318|40.749825,-73.987963&markers=color%3ablue|label%3aS|40.737102,-73.990318|40.749825,-73.987963

      geolocations = map.coordinates.map do |coordinate|
        location_to_param(coordinate.symbolize_keys)
      end

      geolocations.push(geolocations.first)

      "path=color:0x000000|weight:5|#{geolocations.join('|')}"
    end

    def location_to_param(location)
      [location[:lat], location[:lng]].join(',')
    end

    def authorized_url(url, params)
      url_for(url, { key: KEY }.merge(params))
    end

    def url_for(url, params)
      url = Addressable::Template.new("#{url}{?query*}")
      url.expand(query: params)
    end
  end
end
