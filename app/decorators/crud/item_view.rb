module Crud
  class ItemView < ViewObject
    def initialize(item)
      @item = item
    end

    def edit_url
      "#{index_url}/#{item.to_param}/edit"
    end

    def new_url
      "#{index_url}/new"
    end

    def url
      "#{index_url}/#{item.to_param}"
    end

    def index_url
      raise "not implemented"
    end

    def form_object
      item
    end

    protected

    attr_reader :item
  end
end

