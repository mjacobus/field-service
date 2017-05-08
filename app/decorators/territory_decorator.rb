class TerritoryDecorator < ActiveRecordModelDecorator
  delegate :name, :uuid, :description, to: :item

  def index_url
    "/territories"
  end

  def householders_url
    url + "/householders"
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
      [to_s],
    ]
  end

  def to_s
    if item.id
      return name
    end

    t('actions.new')
  end
end
