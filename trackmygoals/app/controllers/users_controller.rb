class UsersController < ApplicationController
  def dashboard
    @goals = current_user.goals
    @activities = current_user.activities
  end
end
