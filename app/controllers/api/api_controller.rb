module Api
  class ApiController < AuthenticatedController
    skip_before_action :require_admin

    private

    # Map controller + action to endpoint. I.E.
    # TerritoriesController#show => Endpoints::Territories::ShowEndpoint
    # Then instantiate it and delegates payload to the perform method
    def perform_with(*payload)
      endpoint = params[:action].classify
      module_name = self.class.to_s.split('::').last.gsub('Controller', '')
      class_name = "Endpoints::#{module_name}::#{endpoint}Endpoint"
      klass = class_name.constantize
      response = klass.new(current_user: current_user).perform(*payload)

      render json: response.to_h, status: response.status
    end
  end
end
