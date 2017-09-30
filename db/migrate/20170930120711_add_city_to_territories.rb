class AddCityToTerritories < ActiveRecord::Migration[5.0]
  def change
    add_column :territories, :city, :string, index: true
  end
end
