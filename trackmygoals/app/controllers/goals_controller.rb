class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :check_user_plan, only: [:create]
  
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      flash[:success] = "Your goal has been created!"
      redirect_to dashboard_path
    else
      flash[:danger] = @goal.errors.full_messages.join(", ")
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @goal.update(goal_params)
      flash[:success] = "Goal was successfully updated!"
      redirect_to goal_path(@goal)
    else
      flash[:danger] = @goal.errors.full_messages.join(", ")
      render 'edit'
    end
  end
  
  def show
    @activities = @goal.activities
    @goal_activities = @goal.activities.reverse
  end
  
  def index
    @user = current_user
    @user_goals = @user.goals
  end
  
  def destroy
    @goal.destroy
    flash[:danger] = "Goal was successfully deleted!"
    redirect_to dashboard_path
  end
  
  def dashboard
    @goal = Goal.new
    @user_goals = current_user.goals
    @activities = current_user.activities
  end
  
  def dashboardtest
    @goal = Goal.new
    @user_goals = current_user.goals
    @activities = current_user.activities
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:name, :description, :xp_value, :recurrence_id)
  end
  
  def set_goal
    @goal = Goal.find(params[:id])
  end
  
  def require_same_user
    if @goal.user != current_user
      flash[:danger] = "You can only access your own goals."
      redirect_to root_path
    end
  end
  
  def check_user_plan
    if !current_user.is_premium && current_user.goals.count == 3
      flash[:danger] = "You have reached the goal limit for free users. Upgrade for unlimited goals!"
      return redirect_to goals_path
    end
  end
end