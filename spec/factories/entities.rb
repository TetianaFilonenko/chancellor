FactoryGirl.define do
  factory :entity do
    cached_long_name { name }
    display_name { name }
    name { Faker::Company.name }
    reference { Faker::Number.number(8) }
    uuid { UUID.generate(:compact) }

    after :build do |entity, _evaluator|
      location = build(:location, :entity => entity)
      entity.primary_location = location
    end

    after :create do |entity, _evaluator|
      entity.save!
      location = create(:location,
                        :entity => entity,
                        :location_name => entity.name)
      entity.primary_location = location
      entity.save!
    end
  end
end
