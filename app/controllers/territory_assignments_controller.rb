class TerritoryAssignmentsController < ApplicationController
  def index
    @territories = Territory.sorted
  end

  def new
    @territory = create_decorator(TerritoryAssignmentDecorator, territory)
  end

  def create
    payload = params.require(:assignment).symbolize_keys

    TerritoryAssigning.new.perform(payload)

    redirect_to territories_url, notice: t('territories.assigned')
  end

  def destroy
    payload = { territory_id: params[:territory_id] }

    ReturnTerritory.new.perform(payload)

    redirect_to territories_url, notice: t('territories.returned')
  end

  private

  def territory
    @_territory ||= Territory.find(params[:territory_id])
  end
end
