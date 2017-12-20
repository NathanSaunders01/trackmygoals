class Contact < ActiveRecord::Base
  validates :comments, presence: true
end