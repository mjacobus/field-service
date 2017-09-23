class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  private

  def create_decorator(*args)
    klass = args.shift
    klass.new(*args).with_view_helpers(view_context)
  end

  def search_params
    allowed = %i[assigned_to_ids pending_return inactive_from]

    new_params = params.symbolize_keys.select do |key, _value|
      allowed.include?(key)
    end

    if new_params[:inactive_from].present?
      new_params[:inactive_from] = Date.parse(new_params[:inactive_from])
    end

    new_params
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
end
