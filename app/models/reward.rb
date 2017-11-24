class Reward < ActiveRecord::Base
  belongs_to :user
  has_many :reward_goals
  has_many :goals, through: :reward_goals
  
  validates :name, presence: true
  validates :xp_goal, presence: true
  
  after_create :sum_goal_xp
  
  def sum_goal_xp
    if self.assign_all_goals
      @user = self.user
      @user.goals.map {|goal| [goal.activities.where("created_at >= ?", self.created_at).sum(:total_xp)]}.sum.sum
    else
      self.goals.map {|goal| [goal.activities.where("created_at >= ?", self.created_at).sum(:total_xp)]}.sum.sum
    end
  end
  
  def assign_all_goals
    @user = self.user
    if self.goals.count == @user.goals.where("created_at <= ? AND completed = ?", self.updated_at, false).count
      true
    else
      false
    end
  end
  
end