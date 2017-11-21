class AddRecurrenceToGoal < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :recurrence_id, :integer
  end
end
