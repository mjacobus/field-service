class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  private

  def create_decorator(*args)
    klass = args.shift
    klass.new(*args).with_view_helpers(view_context)
  end

  def search_params
    allowed = %i[assigned_to_ids pending_return]
    params.symbolize_keys.select do |key, _value|
      allowed.include?(key)
    end
  end

  def export_pdf(export_type, options = {})
    file_name = DatePath.new(prefix: "#{export_type}_").to_s

    default_options = {
      pdf: file_name,
      layout: 'pdf',
      header: { right: '[page] of [topage]' }
    }

    render(default_options.merge(options))
  end
end
