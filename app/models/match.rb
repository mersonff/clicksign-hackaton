# frozen_string_literal: true

# Match model
class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :stage

  validates :home_team_goals, :away_team_goals, :start_at, presence: true
  validates :home_team_goals, :away_team_goals, numericality: { greater_than_or_equal_to: 0 }
  validate :home_team_cannot_be_away_team

  scope :finished, -> { where(finished_at: ..Time.current) }

  scope :unfinished, -> { where(start_at: ..Time.current, finished_at: Time.current..) }

  def home_team_cannot_be_away_team
    errors.add(:home_team, 'cannot be the same as away team') if home_team == away_team
  end

  def self.flag_url(team)
    return nil unless team.flag.attached?

    Rails.application.routes.url_helpers.rails_blob_url(team.flag, host: 'http://localhost:3000')
  end

  def self.match_format(match) # rubocop:todo Metrics/AbcSize
    {
      id: match.id,
      stage: match.stage.name,
      home: match.home_team.name,
      away: match.away_team.name,
      homeGoals: match.home_team_goals,
      awayGoals: match.away_team_goals,
      homeFlag: flag_url(match.home_team),
      awayFlag: flag_url(match.away_team),
      time: (Time.current - match.start_at) / 1.minute
    }
  end

  def self.update_matches!
    unfinished.each { |match| increment_goals(match) }
    broadcast_matches
    enqueue_next_job
  end

  def self.increment_goals(match)
    match.update!(
      home_team_goals: match.home_team_goals + goals_sample,
      away_team_goals: match.away_team_goals + goals_sample
    )
    true
  end

  def self.goals_sample
    [*[0] * 99, * [1] * 1].sample
  end

  def self.enqueue_next_job
    UpdateMatchesJob.set(wait: 1.minute).perform_later
  end

  def self.broadcast_matches
    ActionCable.server.broadcast 'matches_channel', { matches: unfinished.map { |match| match_format(match) } }
  end
end
