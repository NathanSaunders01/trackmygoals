class CreateRewardGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :reward_goals do |t|
      t.integer :reward_id
      t.integer :goal_id
    end
  end
end
