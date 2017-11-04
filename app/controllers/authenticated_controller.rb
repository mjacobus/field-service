class AuthenticatedController < ApplicationController
  before_action :require_login

  def urls
    @urls ||= ApiHelpers::UrlHelper.new
  end
end
