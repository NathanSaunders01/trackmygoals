class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :reward_goals
  has_many :rewards, through: :reward_goals
  
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
  
  def monthly_goal_xp
    self.activities.where("created_at >= ?", 1.month.ago.in_time_zone).sum(:total_xp)    
  end
  
  def calculate_streak
    if self.calculate_length_of_streak >= 5 || (self.calculate_length_of_streak == 4 && self.empty_current_period)
      return 1.2
    else
      return 1
    end  
  end
  
  def calc_streak
    streak = 0
    days = self.activities.group_by_day(:created_at).count.reject { |day, count| count == 0 }
    days.reverse_each do |day, count|
      break if day != (streak+self.empty_current_period).days.ago.in_time_zone(Time.zone).to_date
      streak+=1
    end
    streak
  end
  
  def calculate_length_of_streak
    streak = 0
    if self.recurrence_id == 1 
      days = self.activities.group_by_day(:created_at).count.reject { |day, count| count == 0 }
      days.reverse_each do |day, count|
        break if day != (streak+self.empty_current_period).days.ago.to_date
        streak+=1
      end
    elsif self.recurrence_id == 2
      weeks = self.activities.group_by_week(:created_at).count.reject { |day, count| count == 0 }
      weeks.reverse_each do |week, count|
        break if week != (streak+self.empty_current_period).weeks.ago.beginning_of_week(:sunday).to_date
        streak+=1
      end
    elsif self.recurrence_id == 3
      months = self.activities.group_by_month(:created_at).count.reject { |day, count| count == 0 }
      months.reverse_each do |month, count|
        break if month == (streak+self.empty_current_period).months.ago.beginning_of_month.to_date
        streak+=1
      end
    end
    streak
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
  
  def warn_streak_loss
    if (self.calculate_streak == 1.2 && (self.empty_current_period == 1))
      return true
    end
  end
  
  def days_to_streak
    streak = self.calculate_length_of_streak
    5 - streak
  end
  
  def empty_current_period
    if self.recurrence_id == 1 && !self.activities.where("created_at >= ?", Date.today.in_time_zone).exists?
      1
    elsif self.recurrence_id == 2 && !self.activities.where("created_at >= ?", 0.weeks.ago.beginning_of_week(:sunday).in_time_zone(Time.zone)).exists?
      1
    elsif self.recurrence_id == 3 && !self.activities.where("created_at >= ?", 0.months.ago.beginning_of_month.in_time_zone(Time.zone)).exists?
      1
    else
      0
    end
  end
  
  def completed?
		self.completed = true && self.recurrence_id == 4
  end

end