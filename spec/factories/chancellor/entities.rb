FactoryGirl.define do
  factory :entity, :class => Chancellor::Entity do
    cached_long_name { name }
    display_name { name }
    is_active 1
    name { Faker::Company.name }
    reference { Faker::Number.number(8) }
    uuid { UUID.generate(:compact) }
  end
end
