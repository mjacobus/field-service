module Endpoints
  module Territories
    class IndexEndpoint
      def perform(search_params)
        territories = TerritoryService.new.search(search_params)
        ApiResponse::Territories::Index.new(territories)
      end
    end
  end
end
