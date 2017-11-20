module Api
  class TerritoriesController < AuthenticatedController
    def index
      territories = TerritoryService.new.search(search_params)
      response = ApiResponse::Territories::Index.new(territories)
      render json: response.to_h, status: response.status
    end

    def show
      territory = Territory.find_by_slug(params[:slug])
      response = ApiResponse::Territories::Show.new(territory)
      render json: response.to_h, status: response.status
    end

    def update
      territory = Territory.find_by_slug(params[:slug])

      if territory.update(territory_params)
        response = ApiResponse::Territories::Updated.new(territory)
      else
        response = ApiResponse::ValidationError.new(territory.errors)
      end

      render json: response.to_h, status: response.status
    end

    private

    def territory_params
      params.require(:territory).permit(:name, :description, :city)
    end
  end
end
