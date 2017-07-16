class TerritoryDecorator < ActiveRecordModelDecorator
  def index_url
    '/territories'
  end

  def householders_url
    url + '/householders'
  end

  def householders_button
    button_link_with_icon(
      householders_url,
      'torsos-all',
      'warning',
      title: t('titles.householders')
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
    householders.count
  end
end
