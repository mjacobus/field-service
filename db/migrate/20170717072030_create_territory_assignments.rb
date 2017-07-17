class CreateTerritoryAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :territory_assignments do |t|
      t.references :territory, foreign_key: true
      t.references :publisher, foreign_key: true
      t.date :assigned_at, null: false
      t.date :return_date, null: false
      t.boolean :returned, default: false
      t.date :returned_at, default: nil

      t.timestamps
    end
  end
end
