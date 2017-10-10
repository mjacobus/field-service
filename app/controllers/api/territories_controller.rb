module Api
  class TerritoriesController < AuthenticatedController
    def index
      territories = TerritoryService.new.search(search_params)
      response = ApiResponse::Territories::Index.new(territories)
      render json: response.to_h
    end
  end
end
