# frozen_string_literal: true

json.matches do
  json.array! @matches, partial: 'matches/match', as: :match, cached: true
end
