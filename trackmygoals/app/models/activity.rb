class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :goal_activities, dependent: :destroy
  
  validates :quantity, presence: true
  
  after_create :create_goal_activity
  
  def create_goal_activity
    goal_activity = self.goal_activities.where(goal_id: goal_id).first_or_initialize
    goal_activity.update_attributes(:goal_id => goal_id, :user_id => user_id)
  end
  
end