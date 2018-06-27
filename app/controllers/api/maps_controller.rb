module Api
  class MapsController < ApiController
    def index
      perform_with(search_params)
    end
  end
end
