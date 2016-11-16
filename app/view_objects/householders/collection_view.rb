module Householders
  class CollectionView < Crud::IndexView
    def index_url
      '/householders'
    end

    def item_decorator_class
      ItemView
    end
  end
end
