class ActivitiesController < ApplicationController
  
  def new
    @activity = Activity.new
  end
  
  def create
    @activity = Activity.new(activity_params)
    @activity.goal = Goal.find(params[:goal_id])
    @activity.user = current_user
    @activity.total_xp = @activity.goal.calculate_total_activity_xp(@activity.quantity)
    if @activity.save
      flash[:success] = "You just gained #{@activity.total_xp} XP!"
      redirect_to root_path
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
      redirect_to root_path
  end
  
  private

  def activity_params
    params.require(:activity).permit(:quantity, :total_xp)
  end
  
end