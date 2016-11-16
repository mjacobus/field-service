module Territories
  class CollectionView < Crud::IndexView
    def index_url
      '/territories'
    end

    def item_class
      ItemView
    end
  end
end
