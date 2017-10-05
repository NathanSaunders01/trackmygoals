class GoalActivity < ActiveRecord::Base
  belongs_to :goal
  belongs_to :activity, dependent: :destroy
  belongs_to :user
end