module Endpoints
  class AdminEndpoint < BaseEndpoint
    # admin endpoints should respond to perform_as_admin
    def perform(*args)
      if current_user.admin?
        return perform_as_admin(*args)
      end

      ApiResponse::ForbiddenResponse.new
    end
  end
end
