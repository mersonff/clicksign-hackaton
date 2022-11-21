# frozen_string_literal: true

json.extract! match, :id, :start_at, :finished_at
json.home do
  json.partial! 'teams/team', team: match.home_team
  json.goals match.home_team_goals
end
json.away do
  json.partial! 'teams/team', team: match.away_team
  json.goals match.away_team_goals
end
json.stage do
  json.partial! 'stages/stage', stage: match.stage
end
json.url match_url(match)
