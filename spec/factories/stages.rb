FactoryBot.define do
  factory :stage do
    name { Faker::Internet.uuid }
  end
end
