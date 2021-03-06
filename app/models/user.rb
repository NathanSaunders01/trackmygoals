class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # belongs_to :plan
  has_many :goals
  has_many :activities
  has_many :rewards
  
  # after_touch :check_user_rewards_expiration
  
  attr_accessor :stripe_card_token
  
  #def check_user_rewards_expiration
   # self.rewards do
    #  
  #  end
  #end
  
  def suggest_weekly_xp_target
    todo_xp = self.goals.where("recurrence_id = ? AND completed = ?", 1, false).sum(:xp_value)
    ongo_goals = self.goals.where("recurrence_id = ?", 2)
    ongo_sum = 0
    ongo_goals.each do |goal|
      ongo_sum += (goal.xp_value * goal.frequency)
    end
    return (todo_xp + ongo_sum)
  end
  
  def user_xp_change_week
    xp_last_week = self.activities.where("created_at >= ? AND created_at < ?", 1.week.ago.beginning_of_week, (DateTime.now.in_time_zone - 1.week)).sum(:total_xp)
    if (self.user_xp_this_week == 0 || xp_last_week == 0)
      return "NaN"
    else
      return ((self.user_xp_this_week.to_f / xp_last_week.to_f) * 100).to_i
    end
  end
  
  def user_xp_this_week
    self.activities.where("created_at >= ?", 0.weeks.ago.beginning_of_week).sum(:total_xp)
  end
  
  def to_s
    email
  end
  
  def save_with_subscription
    if valid?
      customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      save!
    end
  end
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
  def is_premium
    if self.plan_id == 2
      return true
    else
      return false
    end
  end
  
  def total_user_xp
    total_activities_sum = self.goals.sum(&:total_goal_xp)
    return (total_activities_sum)
  end
  
  def check_week_reward
    if self.rewards.where("period = ?", 1).exists?
      true
    else
      false
    end
  end
  
  def check_month_reward
    if self.rewards.where("period = ?", 2).exists?
      true
    else
      false
    end
  end
  
  def check_three_month_reward
    if self.rewards.where("period = ?", 3).exists?
      true
    else
      false
    end
  end
  
  def check_annual_reward
    if self.rewards.where("period = ?", 4).exists?
      true
    else
      false
    end
  end
  
  # def user_xp_today
  #   daily_activities_sum = self.goals.sum(Goal.daily_goal_xp)
  #   return (daily_activities_sum)
  # end
end
