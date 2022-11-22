# frozen_string_literal: true

json.stages do
  json.array! @stages, partial: 'stages/stage', as: :stage, cached: true
end
