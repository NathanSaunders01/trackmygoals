class AddFrequencyToGoal < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :frequency, :integer
  end
end
