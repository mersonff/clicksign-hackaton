# frozen_string_literal: true

FactoryBot.define do
  factory :stage do
    name { Faker::Internet.uuid }
  end
end
