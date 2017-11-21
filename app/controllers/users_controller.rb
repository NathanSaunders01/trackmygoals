class UsersController < ApplicationController
  def dashboard
    @goal = Goal.new
    @chart_goals = current_user.goals
    @user_goals = current_user.goals.where("completed = ?", false)
    @activities = current_user.activities.limit(20).order('created_at desc')
    @reward = Reward.new
    @user_rewards = current_user.rewards
    @completed_goals = current_user.goals.where("completed = ?", true).order('updated_at desc')
  end
  
end
