class AddResponsibleToTerritories < ActiveRecord::Migration[5.0]
  def change
    add_reference :territories, :responsible
    add_foreign_key :territories, :publishers, column: :responsible_id
  end
end
