class Reward < ActiveRecord::Base
  belongs_to :user
  has_many :reward_goals
  has_many :goals, through: :reward_goals
  
  validates :name, presence: true
  validates :xp_goal, presence: true
  
  after_create :sum_goal_xp
  
  def sum_goal_xp
    self.goals.map {|goal| [goal.activities.where("created_at >= ?", self.created_at).sum(:total_xp)]}.sum.sum
  end
  
end