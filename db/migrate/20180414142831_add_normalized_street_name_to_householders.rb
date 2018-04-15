class AddNormalizedStreetNameToHouseholders < ActiveRecord::Migration[5.1]
  def change
    add_column :householders, :normalized_street_name, :string
    add_index :householders, :normalized_street_name
  end
end
