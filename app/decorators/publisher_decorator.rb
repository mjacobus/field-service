class PublisherDecorator < ActiveRecordModelDecorator
  def index_url
    '/publishers'
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

  def html_classes
    'disabled' unless congregation_member?
  end
end
