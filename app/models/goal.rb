class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :activities, dependent: :destroy
  has_many :reward_goals
  has_many :rewards, through: :reward_goals
  
  validates :name, presence: true
  validates :xp_value, presence: true
  
  def total_goal_xp
    self.activities.sum(:total_xp)
  end
  
  def daily_goal_xp(date)
    self.activities.where(['created_at >= ? AND created_at < ?', date, date + 1]).sum(:total_xp)
  end
  
  def weekly_goal_xp(date)
    start = Date.commercial(Date.today.year, date)
    last = start + 1.week
    self.activities.where(['created_at >= ? AND created_at < ?', start, last]).sum(:total_xp)    
  end  
  
  def monthly_goal_xp(date)
    start = Date.new(Date.today.year, date, 1)
    last = start + 1.month 
    self.activities.where(['created_at >= ? AND created_at < ?', start, last]).sum(:total_xp)
  end
  
  def calculate_streak
    if self.calculate_length_of_streak >= 5 || (self.calculate_length_of_streak == 4 && self.empty_current_period == 1)
      return 1.2
    else
      return 1
    end  
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
    self.xp_value*quantity*self.check_for_bonus*self.check_todo_countdown_xp_change
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
  
  def empty_days
    if self.activities.where("created_at >= ?", 6.days.ago.beginning_of_day).exists?
      true
    else
      false
    end
  end
  
  def empty_weeks
    if self.activities.where("created_at >= ?", 7.weeks.ago.beginning_of_day).exists?
      true
    else
      false
    end
  end
  
  def empty_months
    if self.activities.where("created_at >= ?", 6.months.ago.beginning_of_day).exists?
      true
    else
      false
    end
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

  def check_for_bonus
    if self.recurrence_id == 1
      return 1
    elsif self.recurrence_id == 2 
      start_date = 1.week.ago.beginning_of_week(:monday).beginning_of_day
      end_date = 0.weeks.ago.beginning_of_week(:monday).beginning_of_day
      last_week_activity_count = self.activities.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
      if ((last_week_activity_count == self.frequency) || (self.created_at >= 0.weeks.ago.beginning_of_week(:monday).beginning_of_day)) && self.recurrence_id == 2
        return 1.2
      else
        1
      end
    end
  end
  
  def check_todo_countdown
    (Date.today - self.created_at.to_date).to_i 
  end

  def check_todo_countdown_xp_change
    if self.recurrence_id == 1
      countdown_start = 3
      countdown_end = 13
      if self.check_todo_countdown < countdown_start
        1
      elsif self.check_todo_countdown >= countdown_start && self.check_todo_countdown <= countdown_end
        1-((self.check_todo_countdown - countdown_start).to_f/10.0)
      else
        0
      end
    elsif self.recurrence_id == 2
      1
    end
  end
  
  def check_progress_for_bonus
    start_date = 0.weeks.ago.beginning_of_week(:monday).beginning_of_day
    end_date = DateTime.now
    this_week_activity_count = self.activities.where("created_at >= ? AND created_at <= ?", start_date, end_date).count
  end

end