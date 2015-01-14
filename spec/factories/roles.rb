FactoryGirl.define do
  factory :role, :class => Role do
    name { Faker::Lorem.word }

    trait :admin do
      name 'admin'
    end
    trait :entity_admin do
      name 'entity_admin'
    end
    trait :entity_user do
      name 'entity_user'
    end
    trait :user_admin do
      name 'user_admin'
    end

    factory :user_role_admin do
      name 'admin'
    end
    factory :user_role_entity_admin do
      name 'entity_admin'
    end
    factory :user_role_entity_user do
      name 'entity_user'
    end
    factory :user_role_user_admin do
      name 'user_admin'
    end
  end
end
