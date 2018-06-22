# frozen_string_literal: true

module Endpoints
  module Maps
    class IndexEndpoint < BaseEndpoint
      def perform(search_params = {})
        territories = Territory.with_map

        ApiResponse::Maps::Index.new(
          territories: territories
        )
      end
    end
  end
end
