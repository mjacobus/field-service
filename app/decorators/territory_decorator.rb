class TerritoryDecorator < ActiveRecordModelDecorator
  def index_url
    '/territories'
  end

  def householders_url
    url + '/householders'
  end

  def assign_url
    url + '/assignments/new'
  end

  def return_url
    url + '/assignments/delete'
  end

  def householders_button
    button_link_with_icon(
      householders_url,
      'torsos-all',
      'warning',
      title: t('titles.householders'),
      text: t('titles.householders')
    )
  end

  def assign_button
    button_link_with_icon(
      assign_url,
      'arrow-up',
      '',
      title: t('titles.assign_territory'),
      text: t('titles.assign_territory')
    )
  end

  def return_button
    destroy_button(
      return_url,
      icon: 'refresh',
      button_class: 'warning',
      title: t('titles.return_territory'),
      text: t('titles.return_territory'),
      confirm_message: t('confirm_territory_return', territory: name)
    )
  end

  def form_object
    item
  end

  def breadcrumbs
    [
      [t('titles.territories'), index_url],
      [to_s]
    ]
  end

  def to_s
    return name if item.id

    t('links.new')
  end

  def names_and_addresses
    HouseholdersDecorator.new(householders, item).names_and_addresses
  end

  def number_of_householders
    item.householders.count
  end

  def assigned_at
    l(current_assignment.assigned_at) if assigned?
  end

  def current_assignee_name
    current_assignment.publisher.name if assigned?
  end

  def current_assignee_id
    current_assignment.publisher_id if assigned?
  end

  def return_date
    l(current_assignment.return_date) if assigned?
  end

  def assigned?
    current_assignment
  end

  def html_classes
    classes = []
    classes << 'pending-return' if need_to_be_returned?
    classes.join(' ')
  end

  def householders
    HouseholdersDecorator.new(item.householders, self).with_view_helpers(view_helpers)
  end

  private

  def current_assignment
    @current_assignment ||= item.current_assignment || false
  end
end
