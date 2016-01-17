FactoryGirl::define do
  factory :review do
    sequence(:user_id) { |n| n }
    association :book
  end
end
