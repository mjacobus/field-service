class HouseholderDecorator < ActiveRecordModelDecorator
  delegate :territory, :name, :house_number, :show, :street_name, to: :item

  def index_url
    "/territories/#{item.territory_id}/householders"
  end

  def html_classes
    'disabled' unless show
  end
end
