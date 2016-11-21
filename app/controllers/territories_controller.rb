class TerritoriesController < ApplicationController
  def index
    @territories = Territory.all
    @territories_view = create_view(TerritoriesDecorator, @territories)
  end

  def show
    @territory_view = create_view(TerritoryDecorator, find_territory)
  end

  def new
    @territory_view = create_view(TerritoryDecorator, Territory.new)
  end

  def edit
    @territory_view = create_view(TerritoryDecorator, find_territory)
  end

  def create
    territory = Territory.new(territory_params)

    if territory.save
      redirect_to territory, notice: 'Territory was successfully created.'
    else
      @territory_view = create_view(TerritoryDecorator, territory)
      render :new
    end
  end

  def update
    territory = find_territory
    @territory_view = create_view(TerritoryDecorator, territory)

    if territory.update(territory_params)
      redirect_to territory, notice: 'Territory was successfully updated.'
    else
      territory_view = create_view(TerritoryDecorator, territory)
      render :edit
    end
  end

  def destroy
    territory = find_territory
    territory.destroy

    @territory_view = create_view(TerritoryDecorator, territory)
    redirect_to @territory_view.index_url, notice: 'Territory was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_territory
    Territory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def territory_params
    params.require(:territory).permit(:name, :description)
  end
end
