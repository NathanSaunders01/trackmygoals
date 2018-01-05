class Reward < ActiveRecord::Base
  belongs_to :user
  has_many :reward_goals
  has_many :goals, through: :reward_goals
  
  validates :name, presence: true
  validates :xp_goal, presence: true

  after_create :set_end_date
  
  # def sum_goal_xp
  #   if self.assign_all_goals
  #     @user = self.user
  #     @user.goals.map {|goal| [goal.activities.where("created_at >= ?", self.created_at).sum(:total_xp)]}.sum.sum
  #   else
  #     self.goals.map {|goal| [goal.activities.where("created_at >= ?", self.created_at).sum(:total_xp)]}.sum.sum
  #   end
  # end
  
  # def suggest_weekly_xp_target
  #   this_user = self.user
  #   todo_xp = this_user.goals.where("recurrence_id = ? AND completed = ?", 1, false).sum(:xp_value)
  #   ongo_goals = this_user.goals.where("recurrence_id = ?", 2)
  #   ongo_sum = 0
  #   ongo_goals.each do |goal|
  #     ongo_sum += (goal.xp_value * goal.frequency)
  #   end
  #   return (todo_xp + ongo_sum)
  # end
  
  def set_end_date
    if self.period == 1
      self.update_attribute(:end_date, (self.created_at.end_of_day + 7.days))
    elsif self.period == 2
      self.update_attribute(:end_date, (self.created_at.end_of_day + 1.month))
    elsif self.period == 3
      self.update_attribute(:end_date, (self.created_at.end_of_day + 3.months))
    elsif self.period == 4
      self.update_attribute(:end_date, (self.created_at.end_of_day + 1.year))
    end
  end
  
  def xp_count 
    if self.reward_still_valid
      if self.period == 1
        self.user.activities.where("created_at >= ?", Date.today.beginning_of_week(:monday)).sum(:total_xp)
      elsif self.period == 2
        self.user.activities.where("created_at >= ?", Date.today.beginning_of_month).sum(:total_xp)
      elsif self.period == 3
        self.user.activities.where("created_at >= ?", 2.months.ago.beginning_of_month).sum(:total_xp)
      elsif self.period == 4
        self.user.activities.where("created_at >= ?", 0.years.ago.beginning_of_year).sum(:total_xp)
      end
    end
  end
  
  def reward_still_valid
    if self.period == 1
      if (Date.today.beginning_of_day > self.created_at.end_of_day + 7.days) && self.repeat == false
        self.delete
      else
        true
      end
    elsif self.period == 2
      if (Date.today.beginning_of_day > self.created_at.end_of_day + 1.month) && self.repeat == false
        self.delete
      else
        true
      end
    elsif self.period == 3
      if (Date.today.beginning_of_day > self.created_at.end_of_day + 3.months) && self.repeat == false
        self.delete
      else
        true
      end
    elsif self.period == 4
      if (Date.today.beginning_of_day > self.created_at.end_of_day + 1.year) && self.repeat == false
        self.delete
      else
        true
      end
    end
  end
  
  def calculate_xp_for_reward
    if self.reward_still_valid
      (self.xp_count.to_f/self.xp_goal.to_f)*100
    end
  end
  
  
  def weekly_average
    if self.reward_still_valid
      start_date = Date.today
      time_left = (self.end_date.to_date - start_date).to_i
      xp_left = self.xp_goal - self.xp_count
      if time_left < 7
        average = (xp_left/time_left)
      else
        average = (xp_left/time_left)*7
      end
      if average > xp_left
        xp_left
      else
        average
      end
    end
  end
  
  def calculate_xp_for_reward_by_week
    if self.reward_still_valid
      if self.weekly_average < 1
        return 100
      else
        return ((self.xp_this_week.to_f/self.weekly_average.to_f)*100)
      end
    end
  end
  
  def xp_this_week
    if self.reward_still_valid
      self.user.activities.where("created_at >= ?", Date.today.beginning_of_week(:monday)).sum(:total_xp)
    end
  end
  
end