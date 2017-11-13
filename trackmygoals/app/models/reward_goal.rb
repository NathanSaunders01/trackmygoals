class RewardGoal < ActiveRecord::Base
  belongs_to :reward
  belongs_to :goal
end