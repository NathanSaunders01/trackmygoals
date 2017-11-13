class Reward < ActiveRecord::Base
  belongs_to :user
  has_many :reward_goals
  has_many :goals, through: :reward_goals
  
  validates :name, presence: true
  validates :xp_goal, presence: true
end