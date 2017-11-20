class TerritoryAssignmentsController < AuthenticatedController
  def index
    @territories = TerritoryService.new.search(search_params)

    respond_to do |format|
      format.html
      format.pdf { export_pdf('territory_assignments', orientation: 'Landscape') }
    end
  end

  def new
    @territory = create_decorator(TerritoryAssignmentDecorator, territory)
  end

  def edit
    @territories = TerritoryService.new.search(search_params)
  end

  def update
    payload = params.require(:territory_assignment).permit(:complete)
    assignment = TerritoryAssignment.find(params[:id])

    if assignment.update(payload)
      return head(:ok)
    end

    return head(422)
  end

  def create
    payload = params_as_hash[:assignment].merge(
      territory_id: territory.id
    )

    TerritoryAssigning.new.perform(payload)

    redirect_to urls.territory_show_path(territory)
  rescue
    redirect_to territory_url(territory), alert: t('territories.assignment_error')
  end

  def destroy
    payload = {
      territory_id: territory.id,
      complete: params[:complete],
      returned_at: Date.parse(params[:return_date])
    }

    ReturnTerritory.new.perform(payload)

    redirect_to urls.territory_show_path(territory)
  end

  private

  def territory
    @_territory ||= Territory.find_by_slug(params[:territory_slug])
  end
end
