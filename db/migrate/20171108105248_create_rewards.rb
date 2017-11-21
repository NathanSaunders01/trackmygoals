class CreateRewards < ActiveRecord::Migration[5.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :xp_goal
      t.integer :user_id
      t.timestamps
    end
  end
end
