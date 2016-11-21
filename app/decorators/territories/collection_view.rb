module Territories
  class CollectionView < ActiveRecordCollectionDecorator
    def index_url
      '/territories'
    end

    def item_decorator_class
      TerritoryDecorator
    end
  end
end
