class AddSlugToTerritory < ActiveRecord::Migration[5.0]
  def change
    add_column :territories, :slug, :string
    add_index :territories, :slug, unique: true

    Territory.find_each do |territory|
      territory.name = territory.name
      territory.save!
    end
  end
end
