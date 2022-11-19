# frozen_string_literal: true

# Match model
class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :stage

  validates :home_team_goals, :away_team_goals, :start_at, presence: true
  validates :home_team_goals, :away_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validate :home_team_cannot_be_away_team

  def home_team_cannot_be_away_team
    errors.add(:home_team, 'cannot be the same as away team') if home_team == away_team
  end
end
