module ApiResponse
  class ForbiddenResponse < BaseResponse
    def status
      400
    end
  end
end
