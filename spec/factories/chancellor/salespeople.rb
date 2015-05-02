FactoryGirl.define do
  factory :salesperson, :class => Chancellor::Salesperson do
    reference { Faker::Number.number(10) }
    uuid { UUID.generate(:compact) }
  end
end
