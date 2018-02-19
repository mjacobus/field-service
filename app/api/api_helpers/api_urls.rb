module ApiHelpers
  class ApiUrls
    def territory_url(territory)
      api_path("/territories/#{territory.to_param}")
    end

    private

    def api_path(path)
      path = path.sub(/^\//, '')

      if Rails.env.development?
        return "http://localhost:3000/api/#{path}"
      end

      "/api/#{path}"
    end
  end
end
