# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Plan.create(name: 'basic', price: 0)
Plan.create(name: 'pro', price: 1.99)


30.times do |a|
  Activity.create!(user_id: 1, goal_id: 1, quantity: 2, total_xp: 120, created_at: a+1.days.ago)
end

15.times do |b|
  Activity.create!(user_id: 1, goal_id: 2, quantity: 1, total_xp: 300, created_at: ((b+1)*2).days.ago)
end

4.times do |c|
  Activity.create!(user_id: 1, goal_id: 3, quantity: 1, total_xp: 600, created_at: c+1.weeks.ago)
end

5.times do |d|
  Activity.create!(user_id: 1, goal_id: 4, quantity: 1, total_xp: 900, created_at: ((d+1)*2).weeks.ago)
end

5.times do |e|
  Activity.create!(user_id: 1, goal_id: 5, quantity: 3, total_xp: 360, created_at: (e).weeks.ago)
end