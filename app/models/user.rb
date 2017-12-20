class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # belongs_to :plan
  has_many :goals
  has_many :activities
  has_many :rewards
  
  attr_accessor :stripe_card_token
  
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
