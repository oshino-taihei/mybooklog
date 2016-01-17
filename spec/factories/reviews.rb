FactoryGirl::define do
  factory :review do
    association :user
    association :book
  end
end
