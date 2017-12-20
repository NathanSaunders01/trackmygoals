class PagesController < ApplicationController

  def home
    @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
    @minimum_password_length = User.password_length.min
  end
  
  def about
  end
    
end