module Api
  class HouseholdersController < ApiController
    def create
      perform_with(territory_slug: params[:territory_slug], attributes: new_attributes)
    end

    private

    def new_attributes
      params.require(:householder).permit(
        :street_name,
        :house_number,
        :name,
        :show,
        :notes,
        :do_not_visit_date
      ).to_h.symbolize_keys
    end
  end
end

