module Endpoints
  class AdminEndpoint < BaseEndpoint
    def perform(*args)
      if current_user.admin?
        return perform_as_admin(*args)
      end

      ApiResponse::ForbiddenResponse.new
    end

    private

    def perform_as_admin(*_args)
      raise 'Method not implemented'
    end
  end
end
