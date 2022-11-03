# frozen_string_literal: true

json.extract! stage, :id, :name, :created_at, :updated_at
json.url match_url(stage, format: :json)
