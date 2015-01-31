FactoryGirl.define do
  factory :location do
    city { Faker::Address.city }
    country { 'United States' }
    region { Faker::Address.state }
    region_code { Faker::Address.zip_code }
    street_address { Faker::Address.street_address }
    uuid { UUID.generate(:compact) }

    after :build do |location, _evaluator|
      location.location_name = location.entity.name
    end
  end
end
