module UsersHelper
  def navbar_color
    if user_signed_in?
      if current_user.first_name == "Nathan"
        "#162756".html_safe
      elsif current_user.first_name == "John"
        "#73132E".html_safe
      end
    else
      "black".html_safe
    end
  end
  
  def border_color
    if user_signed_in?
      if current_user.first_name == "Nathan"
        "#7986AC".html_safe
      elsif current_user.first_name == "John"
        "#E699AF".html_safe
      end
    else
      "grey".html_safe
    end
  end
  
  def xp_by_day
    column_chart goal_xp_by_day_users_path, stacked: true, height: '350px', width: 'auto', library: {
        chart: {
          margin: [50, 20, 100, 70],
          style: {
            fontFamily: 'Nunito'
          }
        },
        yAxis: {
            title: {
                text: 'XP Gains'
            }
        },
    }
  end
  
  def xp_by_week
    column_chart goal_xp_by_week_users_path, stacked: true, height: '350px', width: 'auto',library: {
        chart: {
          margin: [50, 20, 100, 70],
          style: {
            fontFamily: 'Nunito'
          }
        },
        yAxis: {
            title: {
                text: 'XP Gains'
            }
        }
    }
  end
  
  def xp_by_month
    column_chart goal_xp_by_month_users_path, stacked: true, height: '350px', width: 'auto',library: {
        chart: {
          margin: [50, 20, 100, 70],
          style: {
            fontFamily: 'Nunito'
          }
        },
        yAxis: {
            title: {
                text: 'XP Gains'
            }
        }
    }
  end
  
  
  # def cache_key_day_goal(day)
  #   count = current_user.activities.count
  #   max_updated_at = current_user.goals.maximum(:updated_at).try(:utc).try(:to_s, :number)
  #   "users/daily-#{count}-#{max_updated_at}"
  # end
end