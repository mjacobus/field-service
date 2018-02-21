module Api
  class TerritoriesController < ApiController
    def index
      perform_with(search_params)
    end

    def show
      perform_with(slug: params[:slug])
    end

    def update
      perform_with(slug: params[:slug], attributes: territory_params)
    end

    private

    def territory_params
      params.require(:territory).permit(
        :name,
        :description,
        :city,
        map_coordinates: []
      ).to_h.symbolize_keys
    end
  end
end
