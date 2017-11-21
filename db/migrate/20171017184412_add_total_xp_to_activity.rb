class AddTotalXpToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :total_xp, :integer
  end
end
