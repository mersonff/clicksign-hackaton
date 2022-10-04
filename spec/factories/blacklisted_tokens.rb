FactoryBot.define do
  factory :blacklisted_token do
    token { "MyString" }
    user { nil }
    expire_at { "2022-10-04 20:02:11" }
  end
end
