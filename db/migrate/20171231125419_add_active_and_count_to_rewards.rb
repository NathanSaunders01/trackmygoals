class AddActiveAndCountToRewards < ActiveRecord::Migration[5.0]
  def change
    add_column :rewards, :active, :boolean, null: false, default: true
    add_column :rewards, :use_count, :integer
  end
end
