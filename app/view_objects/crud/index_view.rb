module Crud
  class IndexView < ViewObject
    def initialize(collection)
      @collection = collection
    end

    def index_url
      raise "not implemented"
    end

    def new_url
      "#{index_url}/new"
    end

    def item_class
      raise "not implemented"
    end

    def each(&block)
      collection.each do |item|
        block.call(item_class.new(item))
      end
    end

    protected

    attr_reader :collection
  end
end
