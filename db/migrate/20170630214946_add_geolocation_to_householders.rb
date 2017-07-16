class AddGeolocationToHouseholders < ActiveRecord::Migration[5.0]
  def change
    add_column :householders, :lat, :float, null: true
    add_column :householders, :lon, :float, null: true
  end
end
