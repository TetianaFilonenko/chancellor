FactoryGirl.define do
  factory :customer do
    is_active 1
    reference { Faker::Number.number(10) }
    uuid { UUID.generate(:compact) }
  end
end
