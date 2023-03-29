FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Basic #{n}" }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 1..100) }
    productable { nil }
  end
end
