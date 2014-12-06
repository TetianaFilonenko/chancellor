FactoryGirl.define do
  factory :entity do    
    cached_long_name { name }
    city { Faker::Address.city }
    country { 'United States' }
    display_name { name }
    name { Faker::Company.name }
    reference { Faker::Number.number(8) }
    region { Faker::Address.state }
    region_code { Faker::Address.zip_code }
    street_address { Faker::Address.street_address }
    uuid { UUID.generate(:compact) }
  end
end