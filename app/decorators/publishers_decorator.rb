class PublishersDecorator < ActiveRecordCollectionDecorator
  def index_url
    '/publishers'
  end

  def item_decorator_class
    PublisherDecorator
  end

  def breadcrumbs
    [
      [t('titles.publishers')]
    ]
  end

  def title_for(attribute_name)
    PublisherDecorator.new(Publisher.new).title_for(attribute_name)
  end
end
