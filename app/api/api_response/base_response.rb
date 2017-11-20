module ApiResponse
  class BaseResponse
    def urls
      @urls ||= ApiHelpers::UrlHelper.new
    end

    def status
      200
    end
  end
end
