class ChangeConfigurationValuesSize < ActiveRecord::Migration[5.1]
  def change
    change_column :configurations, :values, :text
  end
end
