module Api
  class ApiController < AuthenticatedController

    # Map controller + action to endpoint. I.E.
    # TerritoriesController#show => Endpoints::Territories::ShowEndpoint
    # Then instantiate it and delegates payload to the perform method
    def perform_with(*payload)
      endpoint = params[:action].classify
      module_name = self.class.to_s.split('::').last.gsub('Controller', '')
      class_name = "Endpoints::#{module_name}::#{endpoint}Endpoint"
      response = class_name.constantize.new.perform(*payload)

      render json: response.to_h, status: response.status
    end
  end
end
