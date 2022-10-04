FactoryBot.define do
  factory :refresh_token do
    token { "MyString" }
    user { nil }
    expire_at { "2022-10-04 20:01:11" }
  end
end
