# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    home_team { create(:team) }
    away_team { create(:team) }
    home_team_goals { 1 }
    away_team_goals { 2 }
    start_at { Time.current }
    finished_at { 90.minutes.from_now }
    stage { create(:stage) }
  end
end
