# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'john@clicksign.com' }
    password { 'foobar123' }
    token_issued_at { Time.current }
  end
end
