module ApiHelpers
  class UrlHelper
    def householder_edit_path(householder)
      backend_path("/territories/#{householder.territory.slug}/householders/#{householder.to_param}/edit")
    end

    def territory_index_path(territory)
      frontend_path("/app/territories/#{territory.to_param}")
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
