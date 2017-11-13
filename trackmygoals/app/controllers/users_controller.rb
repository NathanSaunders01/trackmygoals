class UsersController < ApplicationController
  def dashboard
    @goal = Goal.new
    @user_goals = current_user.goals
    @activities = current_user.activities
    @reward = Reward.new
    @user_rewards = current_user.rewards
  end
end
