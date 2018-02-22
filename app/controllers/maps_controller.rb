class MapsController < AuthenticatedController
  layout 'google_maps'

  def show
    territory

    if params[:print].present?
      render :print
    end
  end

  def new
    territory
  end

  def edit
    unless territory.mapped?
      redirect_to url_helpers.new_territory_map(territory)
    end
  end

  private

  def territory
    @territory ||= Territory.find_by_slug(params[:territory_slug])
  end
end
