class CreateTerritories < ActiveRecord::Migration[5.0]
  def change
    create_table :territories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :territories, :name, unique: true
  end
end
