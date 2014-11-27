FactoryGirl.define do
  factory :entity do    
    name { Faker::Company.name }
    uuid { UUID.generate(:compact) }
  end
end