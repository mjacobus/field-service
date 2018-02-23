class AddOverseerFlagToPublishers < ActiveRecord::Migration[5.1]
  def change
    add_column :publishers, :overseer, :boolean, default: false
  end
end
