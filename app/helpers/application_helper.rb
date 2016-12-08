module ApplicationHelper
  def breadcrumbs(parts)
    BreadcrumbsRenderer.new(self).render(parts)
  end
end
