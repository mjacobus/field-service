module ApplicationHelper
  def configuration
    @_app_config ||= Configuration.create_config_object
  end

  def breadcrumbs(parts)
    return if parts.empty?
    content_for(:breadcrumbs) do
      render partial: 'breadcrumbs', locals: { parts: parts }
    end
  end

  def breadcrumbs_for(object)
    raise "Needs to implement 'breadcrumbs'" unless object.respond_to?(:breadcrumbs)
    breadcrumbs(object.breadcrumbs)
  end

  def button_group(*buttons)
    render partial: 'button_group', locals: {
      buttons: buttons,
      type: ''
    }
  end

  def small_button_group(*buttons)
    render partial: 'button_group', locals: {
      buttons: buttons,
      type: 'small'
    }
  end

  def page_title(title)
    content_for(:title, title)
  end

  def body_class
    if root_url =~ /staging|localhost/
      return 'development-env'
    end

    'production-env'
  end

  def symbolized_params
    params.permit!.to_h.deep_symbolize_keys
  end

  def query_string_params
    @query_string_params ||= begin
       (Addressable::URI.parse(request.url).query_values || {}).symbolize_keys
     end
  end

  def urls
    @urls ||= ApiHelpers::UrlHelper.new
  end

  def api_urls
    @api_urls ||= ApiHelpers::ApiUrls.new
  end
end
