# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Plan.create(name: 'basic', price: 0)
Plan.create(name: 'pro', price: 1.99)

# 3.times do |a|
#   Activity.create!(user_id: 5, goal_id: 31, quantity: "#{a}".to_i, total_xp: 100*"#{a}".to_i, created_at: a.days.ago)
# end

# 1.times do |a|
#   Activity.create!(user_id: 4, goal_id: 24, quantity: 2, total_xp: 200, created_at: 4.days.ago)
# end