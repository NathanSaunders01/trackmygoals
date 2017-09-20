class AddUserToGoal < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :user_id, :integer, foreign_key: true
  end
end
