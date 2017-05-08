class AddUuidToHouseholders < ActiveRecord::Migration[5.0]
  def change
    add_column :householders, :uuid, :string, unique: true
  end
end
