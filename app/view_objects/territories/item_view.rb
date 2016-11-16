module Territories
  class ItemView < ViewObject
    delegate :name, :description, to: :item

    def initialize(item)
      @item = item
    end

    def edit_url
      "/territories/#{item.to_param}/edit"
    end

    def url
      "/territories/#{item.to_param}"
    end

    def index_url
      "/territories"
    end

    def form_object
      item
    end

    private

    attr_reader :item
  end
end
