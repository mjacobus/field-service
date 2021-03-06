class TerritoryAssignmentDecorator < ActiveRecordModelDecorator
  def candidates
    @candidates ||= Publisher.congregation_members.sorted.search(search: params[:q])
  end

  def assignments_url
    "/territories/#{to_param}/assignments"
  end

  def search_url
    "/territories/#{to_param}/assignments/new?q={#{encode(search_term)}}"
  end

  def search_term
    params[:q]
  end

  def assignment_confirmation_message(publisher)
    t('confirm_assignment_for_publisher', publisher: publisher.name)
  end
end
