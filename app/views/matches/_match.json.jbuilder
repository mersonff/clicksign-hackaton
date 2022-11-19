# frozen_string_literal: true

json.extract! match, :id, :home_team_id, :away_team_id, :home_team_goals, :away_team_goals, :start_at, :finished_at, :stage_id, :created_at, :updated_at
json.url match_url(match, format: :json)
