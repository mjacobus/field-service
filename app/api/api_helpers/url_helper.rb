module ApiHelpers
  class UrlHelper
    def householder_edit_path(householder)
      backend_path(
        "/territories/#{householder.territory.slug}/householders/#{householder.to_param}/edit"
      )
    end

    def householder_destroy_path(householder)
      backend_path(
        "/territories/#{householder.territory.to_param}/householders/#{householder.to_param}"
      )
    end

    def territory_show_path(territory)
      territory_path(territory)
    end

    def edit_territory(territory)
      "#{territory_path(territory)}/edit"
    end

    def territory_path(territory)
      frontend_path("/app/territories/#{territory.to_param}")
    end

    def territory_index_path
      frontend_path('/app/territories')
    end

    def territory_return_path(territory)
      backend_path("/territories/#{territory.to_param}/assignments/delete")
    end

    def territory_assign_path(territory)
      backend_path("/territories/#{territory.to_param}/assignments/new")
    end

    def territory_map_path(territory)
      backend_path("/territories/#{territory.to_param}/map")
    end

    def edit_territory_map(territory)
      backend_path("/territories/#{territory.to_param}/map/edit")
    end

    def print_territory_map(territory, _params = {})
      backend_path("/territories/#{territory.to_param}/map?print=true")
    end

    def download_territory_pdf(territory, params = {})
      backend_path("/territories/#{territory.to_param}.pdf?#{params.to_query}")
    end

    def new_territory_map(territory)
      backend_path("/territories/#{territory.to_param}/map/new")
    end

    private

    def backend_path(path)
      if Rails.env.development?
        return "http://localhost:3000#{path}"
      end

      path
    end

    def frontend_path(path)
      if Rails.env.development?
        return "http://localhost:3001#{path}"
      end

      path
    end
  end
end
