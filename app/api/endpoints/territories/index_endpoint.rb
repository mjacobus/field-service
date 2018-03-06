module Endpoints
  module Territories
    class IndexEndpoint < AdminEndpoint
      private

      def perform_as_admin(search_params)
        territories = TerritoryService.new.search(search_params)
        ApiResponse::Territories::Index.new(territories)
      end
    end
  end
end
