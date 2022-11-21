# frozen_string_literal: true

json.teams do
  json.array! @teams, partial: 'teams/team', as: :team, cached: true
end
