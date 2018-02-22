require 'addressable/template'

module HereMapsHelper
  def here_maps
    @_here_maps ||= HereMapsHelperObject.new(
      app_id: ENV.to_h.fetch('HERE_APP_ID'),
      app_code: ENV.to_h.fetch('HERE_APP_CODE')
    )
  end

  class HereMapsHelperObject
    ROUTE_PATH = 'https://image.maps.cit.api.here.com/mia/1.6/route'.freeze

    def initialize(app_id:, app_code:)
      @app_id = app_id
      @app_code = app_code
    end

    def image_url(territory, _query_params = {})
      map = territory.map

      params = {
        w: 2048,
        h: 2048,
        r0: borders(map),
        lc0: 'e9a3ff',
        sc0: 'white',
        lw0: 20
      }

      markers(map).each_with_index do |marker, index|
        marker_key = "poix#{index}"
        params[marker_key] = marker
      end

      authorized_url(ROUTE_PATH, params).to_s
    end

    private

    def borders(map)
      geolocations = map.coordinates.map do |coordinate|
        location_to_param(coordinate.symbolize_keys)
      end

      geolocations.push(geolocations.first).join(',')
    end

    # Each marker has the format:
    # lat,lon;bg-color;font-color;font-size;label
    def markers(map)
      map.markers.with_geolocation.map.with_index do |marker, _index|
        marker_location = marker.geolocation
        geolocation = location_to_param(marker_location)
        bg = marker_location[:visit] ? '4a6da7' : 'white'
        color = marker_location[:visit] ? 'white' : 'black'

        [geolocation, bg, color, 14, '.'].join(';')
      end
    end

    def location_to_param(location)
      [location[:lat], location[:lng]].join(',')
    end

    def authorized_url(url, params)
      url = Addressable::Template.new("#{url}{?query*}")
      url.expand(query: params.merge(app_id: @app_id, app_code: @app_code))
    end
  end
end
