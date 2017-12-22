class AddEndDateToRewards < ActiveRecord::Migration[5.0]
  def change
    add_column :rewards, :end_date, :datetime
    add_column :rewards, :repeat, :boolean, null: false, default: false
  end
end
