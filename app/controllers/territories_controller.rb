class TerritoriesController < AuthenticatedController
  def index
    @territories = TerritoryService.new(user: current_user).search(search_params)
    @territories_decorator = create_decorator(TerritoriesDecorator, @territories)

    respond_to do |format|
      format.html
      format.pdf { export_pdf('territories_') }
    end
  end

  def show
    @territory_decorator = create_decorator(TerritoryDecorator, find_territory)

    respond_to do |format|
      format.html
      format.pdf do
        export_pdf("territory_#{@territory_decorator.name.parameterize}")
      end
    end
  end

  def new
    @territory_decorator = create_decorator(TerritoryDecorator, Territory.new)
  end

  def edit
    @territory_decorator = create_decorator(TerritoryDecorator, find_territory)
  end

  def create
    territory = Territory.new(territory_params)

    if territory.save
      redirect_to territory, notice: t('territories.created')
    else
      @territory_decorator = create_decorator(TerritoryDecorator, territory)
      render :new
    end
  end

  def update
    territory = find_territory
    @territory_decorator = create_decorator(TerritoryDecorator, territory)

    if territory.update(territory_params)
      redirect_to territory, notice: t('territories.updated')
    else
      render :edit
    end
  end

  def destroy
    territory = find_territory

    begin
      Territory.remove(territory)
      notice = { notice: t('territories.destroyed') }
    rescue
      notice = { alert:  t('territories.cannot_destroy') }
    end

    @territory_decorator = create_decorator(TerritoryDecorator, territory)
    redirect_to @territory_decorator.index_url, notice
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_territory
    Territory.find_by_slug(params[:slug])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def territory_params
    params.require(:territory).permit(:name, :description, :city, :responsible_id)
  end
end
