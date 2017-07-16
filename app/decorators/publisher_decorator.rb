class PublisherDecorator < ActiveRecordModelDecorator
  delegate :name,
           :id,
           :email,
           :phone,
           to: :item

  def index_url
    "/publishers"
  end

  def breadcrumbs
    expected = [
      [t('titles.publishers'), index_url],
      [to_s]
    ]
  end

  def to_s
    return name if id

    t('links.new')
  end
end
