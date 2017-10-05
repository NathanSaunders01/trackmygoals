class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :quantity
      t.belongs_to :goal, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
