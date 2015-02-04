FactoryGirl.define do
  factory :salesperson do
    reference { Faker::Number.number(10) }
    uuid { UUID.generate(:compact) }
  end
end
