module Territories
  class ItemView < ViewObject
    delegate :name, :description, to: :territory

    def initialize(territory)
      @territory = territory
    end

    def edit_url
      "/territories/#{territory.to_param}/edit"
    end

    def url
      "/territories/#{territory.to_param}"
    end

    def index_url
      "/territories"
    end

    def form_object
      territory
    end

    private

    attr_reader :territory
  end
end
