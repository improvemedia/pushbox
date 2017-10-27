FactoryGirl.define do
  factory :mailing do
    title "Marketing Company"
    template
    dispatch_at { 1.hour.ago }
  end
end
