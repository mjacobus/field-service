module Householders
  class CollectionView < ViewObject
    def initialize(collection)
      @collection = collection
    end

    def index_url
      '/householders'
    end

    def new_url
      '/householders/new'
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
