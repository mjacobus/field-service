class AuthenticatedController < ApplicationController
  before_action :require_login
  before_action :set_authenticity_token

  private

  def urls
    @urls ||= ApiHelpers::UrlHelper.new
  end

  def set_authenticity_token
    cookies[:fs_form_token] = form_authenticity_token
  end
end
