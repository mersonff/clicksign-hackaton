# frozen_string_literal: true

json.extract! team, :id, :name, :description
json.flag_url rails_blob_url(team.flag) if team.flag.attached?
json.url team_url(team)
