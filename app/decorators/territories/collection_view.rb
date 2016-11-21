module Territories
  class CollectionView < Crud::IndexDecorator
    def index_url
      '/territories'
    end

    def item_decorator_class
      ItemView
    end
  end
end
