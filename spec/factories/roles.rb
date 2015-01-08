FactoryGirl.define do
  factory :user_role, :class => User::Role do
    name { Faker::Lorem.word }
  end
end
