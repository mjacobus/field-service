class HouseholdersDecorator < ActiveRecordCollectionDecorator
  def initialize(collection, territory = nil)
    super(collection)
    @territory = territory
  end

  def index_url
    "#{territory_url}/householders"
  end

  def territory_url
    "/territories/#{territory.id}"
  end

  def item_decorator_class
    HouseholderDecorator
  end

  def territory
    @territory or raise "territory was not set"
  end

  def breadcrumbs
    [
      [t('titles.territories'), '/territories'],
      [territory.name, territory_url],
      [t('titles.householders')],
    ]
  end

  def title_for(attribute_name)
    HouseholderDecorator.new(Householder.new).title_for(attribute_name)
  end
end
