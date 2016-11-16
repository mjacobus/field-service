module Territories
  class CollectionView < ViewObject
    def initialize(collection)
      @collection = collection
    end

    def index_url
      '/territories'
    end

    def new_url
      '/territories/new'
    end

    def each(&block)
      collection.each do |item|
        block.call(ItemView.new(item))
      end
    end

    private

    attr_reader :collection
  end
end
