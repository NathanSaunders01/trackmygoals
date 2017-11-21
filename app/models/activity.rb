class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  
  validates :quantity, presence: true
  
end