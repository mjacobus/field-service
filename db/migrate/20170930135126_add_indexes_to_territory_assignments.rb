class AddIndexesToTerritoryAssignments < ActiveRecord::Migration[5.0]
  def change
    index_name = 'assignment_info'
    add_index :territory_assignments, [:complete, :assigned_at, :returned_at], name: index_name
  end
end
