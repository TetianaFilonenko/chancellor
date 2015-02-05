FactoryGirl.define do
  factory :entity do
    cached_long_name { name }
    display_name { name }
    name { Faker::Company.name }
    reference { Faker::Number.number(8) }
    uuid { UUID.generate(:compact) }
  end
end
