FactoryGirl.define do
  factory :user_role, :class => User::Role do
    name { Faker::Lorem.word }

    factory :user_role_admin do
      name 'admin'
    end
    factory :user_role_entity_admin do
      name 'entity_admin'
    end
    factory :user_role_entity_user do
      name 'entity_user'
    end
  end
end
