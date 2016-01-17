FactoryGirl::define do
  factory :user do
    sequence(:name) { |n| "#{Faker::Name.name}_#{n}" }
    password { Faker::Internet.password }
    email { Faker::Internet.email }
  end
end
