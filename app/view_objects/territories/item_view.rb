module Territories
  class ItemView < Crud::ItemView
    delegate :name, :description, to: :item

    def index_url
      "/territories"
    end

    def form_object
      item
    end
  end
end
