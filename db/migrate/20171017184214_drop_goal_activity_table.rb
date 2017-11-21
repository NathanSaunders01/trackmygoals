class DropGoalActivityTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :goal_activities
  end
end
