class TerritoriesController < ApplicationController
  def index
    @territories = Territory.all
    @territories_view = create_view(Territories::CollectionView, @territories)
  end

  def show
    @territory_view = create_view(Territories::ItemView, territory)
  end

  def new
    territory = Territory.new
    @territory_view = create_view(Territories::ItemView, territory)
  end

  def edit
    @territory_view = create_view(Territories::ItemView, territory)
  end

  def create
    @territory = Territory.new(territory_params)

    respond_to do |format|
      if @territory.save
        format.html { redirect_to @territory, notice: 'Territory was successfully created.' }
      else
        format.html do
          @territory_view = create_view(Territories::ItemView, @territory)
          render :new
        end
      end
    end
  end

  def update
    @territory = territory
    @territory_view = create_view(Territories::ItemView, @territory)

    respond_to do |format|
      if @territory.update(territory_params)
        format.html { redirect_to @territory, notice: 'Territory was successfully updated.' }
      else
        format.html do
          @territory_view = create_view(Territories::ItemView, @territory)
          render :edit
        end
      end
    end
  end

  def destroy
    @territory = territory
    @territory_view = create_view(Territories::ItemView, @territory)

    @territory.destroy

    respond_to do |format|
      format.html { redirect_to @territory_view.index_url, notice: 'Territory was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def territory
    Territory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def territory_params
    params.require(:territory).permit(:name, :description)
  end
end
