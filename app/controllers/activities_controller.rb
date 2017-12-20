class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js
  
  def new
    @activity = Activity.new
  end
  
  def create
    @activity = Activity.new(activity_params)
    @activity.goal = Goal.find(params[:goal_id])
    @activity.user = current_user
    @activity.total_xp = @activity.goal.calculate_total_activity_xp(@activity.quantity)
    if @activity.save
      respond_with do |format|
        format.json { render json: @activity }
        format.html do
          if request.xhr?
            render :partial => "activities/activity", :locals => { :activity => @activity }, :layout => false, :status => :created
          else
            redirect_to @activity
          end
        end
      end
    else
      respond_with do |format|
        format.html do
          if request.xhr?
            render :json => @activity.errors, :status => :unprocessable_entity
          else
            render :action => :new, :status => :unprocessable_entity
          end
        end
      end
    end
  end
  
  
  def create_half
    @activity = Activity.new(activity_params)
    @activity.goal = Goal.find(params[:goal_id])
    @activity.user = current_user
    @activity.total_xp = @activity.goal.calculate_total_activity_xp(@activity.quantity)
    respond_to do |format|
      if @activity.save
        format.html # Remove html: { ... } from Activity form/ Include create.js.erb
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
        format.js
      end
    end
    
  end
  
  def create_old
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
    respond_to do |format|
      format.html { }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end
  
  def destroy_old
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