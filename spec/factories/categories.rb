FactoryGirl.define do
  factory :category do
    category_name { Faker::Book.genre }
    association :user
  end

end
