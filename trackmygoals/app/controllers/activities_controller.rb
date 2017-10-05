class ActivitiesController < ApplicationController
  
  def new
    @activity = Activity.new
  end
  
  def create
    @activity = Activity.new(activity_params)
    @activity.goal = Goal.find(params[:goal_id])
    @activity.user = current_user
    if @activity.save
      flash[:success] = "You just gained #{@activity.quantity*@activity.goal.xp_value}xp!"
      redirect_to goal_path(@activity.goal)
    else
      redirect_to new_goal_activity_path(@activity.goal)
      flash[:danger] = "There was a problem logging your activity"
    end
  end
  
  def destroy
    @activity = Activity.find(params[:id])
    @goal = Goal.find(params[:goal_id])
    @activity.destroy
      flash[:danger] = "Activity was successfully destroyed"
      redirect_to goal_path(@activity.goal)
  end
  
  private

  def activity_params
    params.require(:activity).permit(:quantity)
  end
  
end