class RewardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reward, only: [:edit, :update, :show, :destroy]
  
  def new
    @reward = Reward.new(period: params[:period])
  end
  
  def create
    @reward = Reward.new(reward_params)
    @reward.user = current_user
    respond_to do |format|
      if @reward.save
        format.html { redirect_to root_path }
        format.js
      else
        format.html { render 'new' }
      end
    end
  end
  
  def create_old
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
     respond_to do |format|
        if @reward.update(reward_params)
          format.html { redirect_to root_path }
          format.js
        else
          format.html { render 'edit' }
        end
    end
  end
  
  def index
    @user = current_user
    @user_rewards = @user.rewards
  end
  
  def destroy
    @reward.destroy
    flash[:danger] = "Reward was successfully deleted!"
    redirect_to root_path
  end
  
  private
  
  def reward_params
    params.require(:reward).permit(:name, :xp_goal, :period)
  end
  
  def set_reward
    @reward = Reward.find(params[:id])
  end
  
end