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
end