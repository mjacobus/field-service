class MapsController < AuthenticatedController
  layout 'google_maps'

  def show
    territory
  end

  def new
    territory
  end

  def edit
    unless territory.mapped?
      redirect_to url_helpers.new_territory_map_path(territory)
    end
  end

  private

  def territory
    @territory ||= Territory.find_by_slug(params[:territory_slug])
  end
end
