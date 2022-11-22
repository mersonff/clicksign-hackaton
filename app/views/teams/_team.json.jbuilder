# frozen_string_literal: true

json.extract! team, :id, :name, :description
json.flag_url team.flag.attached? ? rails_blob_url(team.flag) : nil
json.url team_url(team)
