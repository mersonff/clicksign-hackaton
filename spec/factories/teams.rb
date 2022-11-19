# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Internet.uuid }
    description { 'Tocou Neymar é gol' }
  end
end
