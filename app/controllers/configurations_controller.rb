# frozen_string_literal: true

class ConfigurationsController < AuthenticatedController
  before_action :require_admin

  def show
    redirect_to edit_configuration_path
  end

  def edit
    @configuration = ::Configuration.create_config_object
  end

  def update
    ::Configuration.update(params[:configuration])
    redirect_to edit_configuration_path, notice: t('configurations.updated')
  end
end
