class AddMapCoordinatesToTerritories < ActiveRecord::Migration[5.1]
  def change
    add_column :territories, :map_coordinates, :json
  end
end
