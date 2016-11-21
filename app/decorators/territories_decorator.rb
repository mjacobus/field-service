class TerritoriesDecorator < ActiveRecordCollectionDecorator
  def index_url
    '/territories'
  end

  def item_decorator_class
    TerritoryDecorator
  end
end
