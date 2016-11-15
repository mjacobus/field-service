class CreateHouseholders < ActiveRecord::Migration[5.0]
  def change
    create_table :householders do |t|
      t.references :territory, foreign_key: true
      t.string :street_name
      t.integer :house_number
      t.string :name
      t.boolean :show

      t.timestamps
    end
  end
end
