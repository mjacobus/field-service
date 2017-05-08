class HouseholderDecorator < ActiveRecordModelDecorator
  delegate :territory,
           :territory_id,
           :name,
           :uuid,
           :house_number,
           :show,
           :street_name,
           :id,
           to: :item

  def index_url
    "/territories/#{territory_id}/householders"
  end

  def html_classes
    'disabled' unless show
  end

  def territory_url
    "/territories/#{territory_id}"
  end

  def breadcrumbs
    [
      [t('titles.territories'), '/territories'],
      [territory.name, territory_url],
      [t('titles.householders'), index_url],
      [to_s]
    ]
  end

  def to_s
    return "#{address} (#{name})" if id

    t('actions.new')
  end

  def address
    "#{street_name} #{house_number}"
  end

  def show?
    boolean_to_human(item.show?)
  end
end
