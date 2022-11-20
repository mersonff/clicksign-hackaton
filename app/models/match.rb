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

  def self.update_matches!
    unfinished.each do |match|
      increment_goals(match)
      verify_if_is_finished(match)
      ActionCable.server.broadcast 'matches_channel', { match: match }
    end
    enqueue_next_job
  end

  def self.unfinished
    Match.where(finished_at: nil)
  end

  def self.increment_goals(match)
    match.update!(
      home_team_goals: match.home_team_goals + goals_sample,
      away_team_goals: match.away_team_goals + goals_sample
    )
    true
  end

  def self.goals_sample
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 1].sample
  end

  def self.verify_if_is_finished(match)
    finished_at = DateTime.current

    return unless match_should_finish?(match, finished_at)

    update(finished_at: finished_at)
  end

  def self.enqueue_next_job
    UpdateMatchesJob.set(wait: 1.minute).perform_later
  end

  def self.overtime
    [1, 2, 3, 4, 5].sample
  end

  def self.match_should_finish?(match, finished_at)
    match.start_at + (90 + overtime).minutes <= finished_at
  end
end
