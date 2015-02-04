FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    display_name { "#{first_name} #{last_name}" }
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :confirmed do
      confirmed_at Time.now
    end

    trait :all_roles do
      confirmed

      after :build do |user, _evaluator|
        Role::ROLE_NAMES.each { |r| user.add_role r }
      end
    end

    trait :admin do
      after :build do |user, _evaluator|
        user.add_role :admin
      end
    end

    trait :authenticated do
      confirmed

      after :build do |user, _evaluator|
        user.add_role :authenticated
      end
    end

    trait :entity_admin do
      after :build do |user, _evaluator|
        user.add_role :entity_admin
      end
    end

    trait :entity_user do
      after :build do |user, _evaluator|
        user.add_role :entity_user
      end
    end

    trait :location_admin do
      after :build do |user, _evaluator|
        user.add_role :location_admin
      end
    end

    trait :user_admin do
      after :build do |user, _evaluator|
        user.add_role :user_admin
      end
    end
  end
end
