class AddUuidToTerritories < ActiveRecord::Migration[5.0]
  def change
    add_column :territories, :uuid, :string, unique: true
  end
end
