module GoalsHelper
  def goal_chart_range
    if @goal.activities.where("created_at >= ?", 1.week.ago.in_time_zone).sum("quantity") == 0
      return 10
    else
      return (@goal.activities.where("created_at >= ?", 1.week.ago.in_time_zone).maximum("quantity+10") )
    end
  end
  
end