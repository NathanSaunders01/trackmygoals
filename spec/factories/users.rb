FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "natha#{n}h@example.com"}
    password "123456"
    password_confirmation "123456"
    plan
  end
end
