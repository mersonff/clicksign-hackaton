# frozen_string_literal: true

json.extract! team, :id, :name, :description, :created_at, :updated_at
json.flag_url rails_blob_url(team.flag) if team.flag.attached?
json.url match_url(team, format: :json)
