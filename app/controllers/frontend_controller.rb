class FrontendController < ApplicationController
  layout 'frontend'

  def index
    render text: :foo
  end

  # I.E.: /static/media/loader.4b6db8c3.gif
  # TODO: Create a middleware for that
  # TODO: Remove middleware and configure deployment/webpack descently
  def redirect_to_asset
    asset = params[:asset].split('.').tap {|p| p << params[:format] }.join('.')
    redirect_to ActionController::Base.helpers.asset_path(asset)
  end
end
