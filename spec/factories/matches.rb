# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    home_team { create(:team) }
    away_team { create(:team) }
    home_team_goals { 1 }
    away_team_goals { 2 }
    start_at { '2022-10-04 19:43:08' }
    finished_at { '2022-10-04 20:43:08' }
    current_time { '2022-10-04 19:53:08' }
    stage { create(:stage) }
  end
end
