class AddDoNotVisitDateToHouseholders < ActiveRecord::Migration[5.0]
  def change
    add_column :householders, :do_not_visit_date, :date, null: true
  end
end
