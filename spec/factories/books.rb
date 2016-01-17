FactoryGirl::define do
  factory :book do
    title { Faker::Book.title }
    asin { Faker::Code.isbn }
  end
end
