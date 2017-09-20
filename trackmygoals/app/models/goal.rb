class Goal < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true
  validates :description, presence: true
  validates :xp_value, presence: true
end