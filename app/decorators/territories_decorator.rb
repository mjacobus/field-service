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
end
