# frozen_string_literal: true

FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    description { 'Tocou Neymar é gol' }
  end
end
