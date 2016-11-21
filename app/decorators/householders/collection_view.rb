module Householders
  class CollectionView < ActiveRecordCollectionDecorator
    def initialize(collection, territory = nil)
      super(collection)
      @territory = territory
    end

    def index_url
      "/territories/#{territory.id}/householders"
    end

    def item_decorator_class
      ItemView
    end

    def territory
      @territory or raise "territory was not set"
    end
  end
end
