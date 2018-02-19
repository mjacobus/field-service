require 'addressable/template'

module GoogleMapsHelper
  def google_maps
    @_google_maps ||= GoogleMapsHelperObject.new(self)
  end

  class GoogleMapsHelperObject
    URL = 'https://maps.googleapis.com/maps/api/js'.freeze
    KEY = 'AIzaSyCMFbHjf-I2rApFaatnmukLyfb1VIB8Jhk'.freeze

    attr_reader :context

    def initialize(context)
      @context = context
    end

    def js_source(params = {})
      url = Addressable::Template.new("#{URL}{?query*}")
      url.expand(query: { key: KEY }.merge(params)).to_s
    end
  end
end
