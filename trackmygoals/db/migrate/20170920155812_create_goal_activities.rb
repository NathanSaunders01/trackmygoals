class CreateGoalActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :goal_activities do |t|
      t.integer :goal_id, foreign_key: true
      t.integer :user_id, foreign_key: true
    end
  end
end
