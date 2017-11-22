FactoryGirl.define do
  factory :goal do
    name "Ride Bike"
    description  "It's fun"
    xp_value 1000
    user
  end
end