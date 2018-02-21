class AssetHelper
  def initialize(adapter = ActionController::Base.helpers)
    @adapter = adapter
  end

  def asset_path(asset)
    adapter.asset_path(asset)
  end

  def image_url(image)
    adapter.image_url(image)
  end

  private

  attr_reader :adapter
end
