class TerritoriesDecorator < ActiveRecordCollectionDecorator
  def index_url
    '/territories'
  end

  def item_decorator_class
    TerritoryDecorator
  end

  def breadcrumbs
    [
      [t('titles.territories')]
    ]
  end

  def title_for(attribute_name)
    TerritoryDecorator.new(Territory.new).title_for(attribute_name)
  end
end
