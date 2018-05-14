module Endpoints
  module Territories
    class IndexEndpoint < BaseEndpoint
      def perform(search_params)
        territories = TerritoryService.new(user: current_user).search(search_params)
        ApiResponse::Territories::Index.new(territories, user: current_user)
      end
    end
  end
end
