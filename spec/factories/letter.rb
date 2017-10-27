FactoryGirl.define do
  factory :letter do
    mailing
    user
    subject "Marketing email"
    content "Hello world"

    trait :sent do
      state :sent
    end
  end
end
