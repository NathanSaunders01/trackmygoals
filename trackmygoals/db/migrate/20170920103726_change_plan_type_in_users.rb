class ChangePlanTypeInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :plan_id, :integer, foreign_key: true
  end
end
