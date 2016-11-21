module Territories
  class CollectionView < ActiveRecordCollectionDecorator
    def index_url
      '/territories'
    end

    def item_decorator_class
      ItemView
    end
  end
end
