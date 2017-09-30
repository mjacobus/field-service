class AddCompleteFlagToTerritoryAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :territory_assignments, :complete, :boolean, index: true
  end
end
