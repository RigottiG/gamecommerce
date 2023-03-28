# frozen_string_literal: true

FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    operational_system { Faker::Computer.os }
    storage { '500gb' }
    processor { 'AMD Ryzen' }
    memory { '8GB' }
    video_board { 'RX 570 8Gb' }
  end
end
