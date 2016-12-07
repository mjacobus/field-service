class TerritoryDecorator < ActiveRecordModelDecorator
  delegate :name, :description, to: :item

  def index_url
    "/territories"
  end

  def householders_url
    url + "/householders"
  end

  def form_object
    item
  end
end
