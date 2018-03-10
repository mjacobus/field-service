module ApiResponse
  class NotFoundResponse < BaseResponse
    def to_h
      { message: 'Not found' }
    end

    def status
      404
    end
  end
end

