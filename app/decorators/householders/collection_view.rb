module Householders
  class CollectionView < Crud::IndexDecorator
    def index_url
      '/householders'
    end

    def item_decorator_class
      ItemView
    end
  end
end
