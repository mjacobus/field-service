class MapsController < AuthenticatedController
  skip_before_action :require_admin, only: [:show]
  layout 'google_maps'

  def index
  end

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
    @territory ||= current_user.territories.find_by_slug(params[:territory_slug])
  end
end
