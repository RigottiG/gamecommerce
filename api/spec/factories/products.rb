# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Basic #{n}" }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 1..400) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/product_image.png')) }
    status { :available }

    after :build do |product|
      product.productable = create(:game)
    end
  end
end
