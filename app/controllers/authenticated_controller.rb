class AuthenticatedController < ApplicationController
  before_action :require_login
  before_action :require_admin
  before_action :set_authenticity_token

  # for test purposes only
  def test
    render plain: 'ok'
  end

  private

  def urls
    @urls ||= ApiHelpers::UrlHelper.new
  end

  def set_authenticity_token
    cookies[:fs_form_token] = form_authenticity_token
  end

  def require_admin
    unless current_user.admin?
      redirect_to urls.login_path
    end
  end
end
