class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :activities
  
  validates :name, presence: true
  validates :description, presence: true
  validates :xp_value, presence: true
  
  def total_goal_xp
    self.activities.sum(:total_xp)
  end
  
  def daily_goal_xp
    self.activities.where("created_at >= ?", Time.zone.now.beginning_of_day).sum(:total_xp)
  end
  
  def weekly_goal_xp
    self.activities.where("created_at >= ?", 1.week.ago.in_time_zone).sum(:total_xp)    
  end  
  
  def calculate_streak
    activities = self.activities.where("created_at >= ?", 2.days.ago.in_time_zone).group("strftime('%Y-%m-%d 00:00:00 UTC', created_at)").count.count
    if activities == 2
      return 1.2
    else
      return 1
    end
  end
  
  def calculate_length_to_streak
    days = self.activities.group("strftime('%Y-%m-%d 00:00:00 UTC', created_at)").count
    streak = 0
    days.reverse_each do |day, count|
      if day == streak.days.ago.beginning_of_day.in_time_zone(Time.zone).to_formatted_s
        streak+=1
      end
    end
    streak.to_f
  end
  
  def calculate_total_activity_xp(quantity)
    self.xp_value*quantity*self.calculate_streak
  end

  def goal_recurrence
    if self.recurrence_id == 1
      return "days"
    elsif self.recurrence_id == 2
      return "weeks"
    elsif self.recurrence_id == 3
      return "months"
    end
  end

end