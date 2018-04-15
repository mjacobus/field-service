class AddHouseNumberAsIntToHouseholders < ActiveRecord::Migration[5.0]
  def change
    add_column :householders, :house_number_as_int, :integer, default: 0
  end
end
