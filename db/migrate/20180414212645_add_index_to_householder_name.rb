class AddIndexToHouseholderName < ActiveRecord::Migration[5.1]
  def change
    add_index :householders, :name
  end
end
