class HouseholderDecorator < ActiveRecordModelDecorator
  def index_url
    territory_url
  end

  def html_classes
    'disabled' unless visit?
  end

  def territory_url
    urls.territory_show_path(territory)
  end

  def url
    "/territories/#{territory.to_param}/householders/#{item.to_param}"
  end

  def form_url
    item.persisted? ? url : create_householder_url
  end

  def create_householder_url(*args)
    "/territories/#{territory.to_param}/householders"
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

    t('links.new')
  end

  def show?
    boolean_to_human(item.show?)
  end

  def do_not_visit_date
    l(item.do_not_visit_date) if do_not_visit_date?
  end
end
