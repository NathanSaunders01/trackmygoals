class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :goal_activities, dependent: :destroy
  has_many :activities, through: :goal_activities
  
  validates :name, presence: true
  validates :description, presence: true
  validates :xp_value, presence: true
end