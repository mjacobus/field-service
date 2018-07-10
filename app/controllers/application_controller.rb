# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  private

  def create_decorator(*args)
    klass = args.shift
    klass.new(*args).with_view_helpers(view_context)
  end

  def search_params
    @seaarch_params ||= filtered_search_params
  end

  def filtered_search_params
    allowed = %i[assigned_to_ids pending_return inactive_from]

    search_params = params_as_hash.select do |key, value|
      allowed.include?(key) && value.present?
    end

    if search_params[:inactive_from].present?
      search_params[:inactive_from] = Date.parse(search_params[:inactive_from])
    end

    @has_filterl_parameters = !search_params.empty?
    search_params
  end

  def export_pdf(export_type, options = {})
    file_name = DatePath.new(prefix: "#{export_type}_").to_s

    default_options = {
      pdf: file_name,
      layout: 'pdf',
      header: {
        right: '[page] of [topage]',
        font_size: 6
      }
    }

    render(default_options.merge(options))
  end

  def params_as_hash
    params.permit!.to_hash.deep_symbolize_keys
  end

  def url_helpers
    @url_helpers ||= ApiHelpers::UrlHelper.new
  end

  def app_config
    @_app_config ||= ::Configuration.create_config_object
  end
end
