module Territories
  class CollectionView < ViewObject
    def initialize(territories)
      @territories = territories
    end

    def index_url
      '/territories'
    end

    def new_url
      '/territories/new'
    end

    def each(&block)
      territories.each do |item|
        block.call(ItemView.new(item))
      end
    end

    private

    attr_reader :territories
  end
end
