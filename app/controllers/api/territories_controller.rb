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
        :responsible_id
      ).to_h.symbolize_keys.tap do |territory|
        if params[:territory].key?(:map_coordinates)
          territory[:map_coordinates] = params[:territory][:map_coordinates].presence
        end

        unless territory[:map_coordinates].nil?
          sub_params = ActionController::Parameters.new(params.permit!.to_h)
                                                   .require(:territory)
                                                   .permit(map_coordinates: %i[lat lng])

          territory[:map_coordinates] = sub_params.to_h[:map_coordinates]
        end
      end
    end
  end
end
