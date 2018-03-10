module Endpoints
  class BaseEndpoint
    def initialize(current_user:)
      @current_user = current_user
    end

    private

    attr_reader :current_user

    def handle_errors
      yield
    rescue ActiveRecord::RecordNotFound
      ApiResponse::NotFoundResponse.new
    end
  end
end
