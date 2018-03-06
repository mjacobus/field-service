module ApiResponse
  class ForbiddenResponse < BaseResponse
    def to_h
      { message: 'Forbidden. Not an admin' }
    end

    def status
      400
    end
  end
end
