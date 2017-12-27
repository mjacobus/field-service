class CreateUserGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_groups do |t|
      # TODO: Figure out why this cannot work
      # t.references :territory, foreign_key: true
      # t.references :publisher, foreign_key: true

      t.integer :user_id
      t.integer :publisher_id

      t.timestamps
    end

    add_index(:user_groups, [:user_id, :publisher_id], unique: true)
  end
end
