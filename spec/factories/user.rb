FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    sequence(:email) { |i| "user-#{i}@example.com" }
  end
end
