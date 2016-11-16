module Householders
  class ItemView < ViewObject
    delegate :name, :description, to: :item

    def initialize(item)
      @item = item
    end

    def edit_url
      "/householders/#{item.to_param}/edit"
    end

    def url
      "/householders/#{item.to_param}"
    end

    def index_url
      "/householders"
    end

    def form_object
      item
    end

    private

    attr_reader :item
  end
end
