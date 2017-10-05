class AddActivityToGoalActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :goal_activities, :activity_id, :integer, foreign_key: true
  end
end
