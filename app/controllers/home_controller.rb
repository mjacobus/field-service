class HomeController < AuthenticatedController
  skip_before_action :require_admin
  def index
  end
end
