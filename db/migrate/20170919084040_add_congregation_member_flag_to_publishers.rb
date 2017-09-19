class AddCongregationMemberFlagToPublishers < ActiveRecord::Migration[5.0]
  def change
    add_column :publishers, :congregation_member, :boolean, default: true
  end
end
