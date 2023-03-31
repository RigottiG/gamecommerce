# frozen_string_literal: true

FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    operational_system { Faker::Computer.os }
    storage { '500GB' }
    processor { 'Intel Core i5' }
    memory { '8GB' }
    video_board { 'Integrated' }
  end
end
