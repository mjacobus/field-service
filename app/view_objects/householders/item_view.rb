module Householders
  class ItemView < Crud::ItemView
    delegate :territory, :name, :house_number, :show, :street_name, to: :item

    def index_url
      "/householders"
    end
  end
end
