module ApiResponse
  module Householders
    class Show < BaseResponse
      def initialize(householder)
        @householder = householder
      end

      def to_h
        {
          data: {
            id: householder.id,
            name: householder.name,
            streetName: householder.normalized_street_name,
            address: householder.address,
            territoryName: householder.territory_name,
            visit: householder.visit?,
            show: householder.show?,
            doNotVisitDate: householder.do_not_visit_date,
            geolocation: {
              present: householder.has_geolocation?,
              lat: householder.lat,
              lon: householder.lon
            },
            links: {
              show: urls.householder_path(householder),
              edit: urls.householder_edit_path(householder),
              destroy: urls.householder_destroy_path(householder),
              territory: urls.territory_path(householder.territory)
            }
          }
        }
      end

      private

      attr_reader :householder
    end
  end
end
