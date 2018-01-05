class UsersController < ApplicationController
  
  def dashboard
    @goal = Goal.new
    @contact = Contact.new
    @reward = Reward.new
    @activity = Activity.new
    @chart_goals = current_user.goals
    @user_goals = current_user.goals.where("recurrence_id = ?", 2)
    @todo_tasks = current_user.goals.where("recurrence_id = ? AND completed = ?", 1, false)
    @activities = current_user.activities.limit(20).order('created_at desc')
    @completed_goals = current_user.goals.where("completed = ?", true).order('updated_at desc')
    @weekly_reward = current_user.rewards.where("period = ?", 1).first
    @monthly_reward = current_user.rewards.where("period = ?", 2).first
    @three_month_reward = current_user.rewards.where("period = ?", 3).first
    @annual_reward = current_user.rewards.where("period = ?", 4).first
  end
  
  def goal_xp_by_day
    
    # Create an array of goals to iterate through if they have activities
    # recorded in the last 7 days.
    days_goals = current_user.goals.select { |g| g.empty_days}
    
    # Iterate through goals and for each goal, create a hash of days and points
    goals = days_goals.map do |goal|
      days = {}
      (Date.today-6..Date.today).each do |day|
        
        # Pass the day to a method which uses the parameter 
        # to calculate the points for that period
          days[day.strftime("%a")] = goal.daily_goal_xp(day)
      end
      {
        name: goal.name,
        data: days
      }
    end
    render json: goals
  end
  
  def goal_xp_by_week
    
    # Create an array of goals to iterate through if they have activities
    # recorded in the last 8 weeks.
    weeks_goals = current_user.goals.select { |g| g.empty_weeks}
    
    # Iterate through goals and for each goal, create a hash of weeks and points  
    goals = weeks_goals.map do |goal|
      
      weeks = {}
      ((0.weeks.ago.beginning_of_week(:monday).to_date.cweek)-7..0.weeks.ago.beginning_of_week(:monday).to_date.cweek).each do |week|
        
        # Add condition to check if current commercial week is negative (the 7 weeks after New Years)
        if week <= 0 
          
          # If so, change year to last year and add 52 weeks to commercial week to bring it to correct value
          # then pass the week to a method which uses the parameter 
          # to calculate the points for that period
          weeks[Date.commercial(Date.today.year - 1, week+52).strftime("%d %b")] = goal.weekly_goal_xp(week)
        else
          weeks[Date.commercial(Date.today.year, week).strftime("%d %b")] = goal.weekly_goal_xp(week)
        end
      end
      {
        name: goal.name,
        data: weeks
      }
    end
    render json: goals
  end
  
  def goal_xp_by_month
    months_goals = current_user.goals.select { |g| g.empty_months}
      
    goals = months_goals.map do |goal|
      months = {}
      ((0.months.ago.beginning_of_month.to_date.mon)-5..0.months.ago.to_date.mon).each do |month|
        if month <= 0
          months[Date.new(Date.today.year - 1, month + 12).strftime("%b")] = goal.monthly_goal_xp(month)
        else
          months[Date.new(Date.today.year, month).strftime("%b")] = goal.monthly_goal_xp(month)
        end
      end
      {
        name: goal.name,
        data: months
      }
    end
    render json: goals
  end
  
end
