class HouseholdersController < AuthenticatedController
  def index
    householders = territory.householders
    @householders_decorator = create_decorator(HouseholdersDecorator, householders, territory)

    respond_to do |format|
      format.html

      format.csv do
        render plain: to_csv(householders)
      end
    end
  end

  def show
    householder = find_householder
    @householder_decorator = create_decorator(HouseholderDecorator, householder)
  end

  def new
    householder = territory.householders.build(show: true)
    @householder_decorator = create_decorator(HouseholderDecorator, householder)
  end

  def edit
    householder = find_householder
    @householder_decorator = create_decorator(HouseholderDecorator, householder)
  end

  def create
    householder = territory.householders.build(householder_params)
    @householder_decorator = create_decorator(HouseholderDecorator, householder)

    # TODO: improve error handling
    begin
      householder.update_geolocation
    rescue
      flash[:alert] = t('messages.geolocation_update_failed')
    end

    if householder.save
      redirect_to urls.territory_index_path(territory)
    else
      render :new
    end
  end

  def update
    householder = find_householder
    @householder_decorator = create_decorator(HouseholderDecorator, householder)

    # TODO: improve error handling
    begin
      householder.update_geolocation
    rescue
      flash[:alert] = t('messages.geolocation_update_failed')
    end

    if householder.update(householder_params)
      redirect_to urls.territory_index_path(territory)
    else
      render :edit
    end
  end

  def destroy
    householder = find_householder
    householder.destroy
    @householder_decorator = create_decorator(HouseholderDecorator, householder)

    redirect_to @householder_decorator.index_url, notice: t('householders.destroyed')
  end

  private

  def territory
    @_territory ||= Territory.find_by_slug(params[:territory_slug])
  end

  # Use callbacks to share common setup or constraints between actions.
  def find_householder
    Householder.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def householder_params
    params.require(:householder).permit(
      :street_name,
      :house_number,
      :name,
      :show,
      :notes,
      :do_not_visit_date
    )
  end

  def to_csv(householders)
    HouseholdersCsvExporter.new.export(householders)
  end
end
