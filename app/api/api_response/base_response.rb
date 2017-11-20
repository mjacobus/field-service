module ApiResponse
  class BaseResponse
    def urls
      @urls ||= ApiHelpers::UrlHelper.new
    end
  end
end
