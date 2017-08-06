class AddHouseNumberAsIntToHouseholders < ActiveRecord::Migration[5.0]
  def change
    add_column :householders, :house_number_as_int, :integer, default: 0

    Householder.where(house_number_as_int: 0).each do |householder|
      householder.house_number = householder.house_number
      householder.save!
    end
  end
end
