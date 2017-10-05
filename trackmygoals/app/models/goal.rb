class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :goal_activities, dependent: :destroy
  has_many :activities, through: :goal_activities
  
  validates :name, presence: true
  validates :description, presence: true
  validates :xp_value, presence: true
  
  def total_goal_xp
    total_activities_sum = self.activities.sum(:quantity)
    return (total_activities_sum*xp_value)
  end
  
  def daily_goal_xp
    daily_activities_sum = self.activities.where("created_at >= ?", Time.zone.now.beginning_of_day).sum(:quantity)
    return (daily_activities_sum*xp_value)
  end
  
  def weekly_goal_xp
    weekly_activities_sum = self.activities.where("created_at >= ?", 1.week.ago.in_time_zone).sum(:quantity)
    return (weekly_activities_sum*xp_value)
  end  
end