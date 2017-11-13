class RewardsController < ApplicationController
  before_action :set_reward, only: [:edit, :update, :show, :destroy]
  
  def new
    @reward = Reward.new
    @goals = current_user.goals
  end
  
  def create
    @reward = Reward.new(reward_params)
    @reward.user = current_user
    if @reward.save
      flash[:success] = "Your reward has been created!"
      redirect_to root_path
    else
      flash[:danger] = @reward.errors.full_messages.join(", ")
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @reward.update(reward_params)
      flash[:success] = "Reward was successfully updated!"
      redirect_to root_path
    else
      flash[:danger] = @reward.errors.full_messages.join(", ")
      redirect_to root_path
    end
  end
  
  def index
    @user = current_user
    @user_rewards = @user.rewards
  end
  
  private
  
  def reward_params
    params.require(:reward).permit(:name, :xp_goal, goal_ids: [])
  end
  
  def set_reward
    @reward = Reward.find(params[:id])
  end
  
end