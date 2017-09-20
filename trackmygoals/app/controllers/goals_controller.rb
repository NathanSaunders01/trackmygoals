class GoalsController < ApplicationController
  
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      flash[:success] = "Your goal has been created!"
      redirect_to goals_path
    else
      flash[:danger] = @goal.errors.full_messages.join(", ")
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def show
    @goal = Goal.find_by_id(params[:id])
  end
  
  def index
  end
  
  def destroy
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:name, :description, :xp_value)
  end
end