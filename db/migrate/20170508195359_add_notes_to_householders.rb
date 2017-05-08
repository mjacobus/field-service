class AddNotesToHouseholders < ActiveRecord::Migration[5.0]
  def change
    add_column :householders, :notes, :text
  end
end
