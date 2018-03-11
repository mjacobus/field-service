class CreateUserPublisher < ActiveRecord::Migration[5.0]
  def change
    create_table :user_publishers do |t|
      t.references :user, foreign_key: true
      t.references :publisher, foreign_key: true
    end
  end
end
