module ApiResponse
  class ValidationError < BaseResponse
    def initialize(errors)
      @errors = errors
    end

    def to_h
      { errors: @errors.to_h }
    end

    def status
      422
    end
  end
end
