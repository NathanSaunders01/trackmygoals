class RemoveActiveAndCountFromRewards < ActiveRecord::Migration[5.0]
  def change
    remove_column :rewards, :active, :boolean, null: false, default: true
    remove_column :rewards, :use_count, :integer
  end
end
