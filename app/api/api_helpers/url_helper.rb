module ApiHelpers
  class UrlHelper
    def householder_edit_path(householder)
      frontend_path("/territories/#{householder.territory.slug}/householders/#{householder.to_param}/edit")
    end

    def territory_show_path(territory)
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

    def householder_destroy_path(householder)
      backend_path("/territories/#{householder.territory.to_param}/householders/#{householder.to_param}")
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
