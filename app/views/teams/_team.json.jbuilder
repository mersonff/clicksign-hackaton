# frozen_string_literal: true

json.extract! team, :id, :name, :description, :created_at, :updated_at
json.url match_url(team, format: :json)
