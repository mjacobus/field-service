module Api
  class PublishersController < AuthenticatedController
    def index
      publishers = Publisher.all.sorted
      response = ApiResponse::Publishers::Index.new(publishers)
      render json: response.to_h
    end
  end
end

