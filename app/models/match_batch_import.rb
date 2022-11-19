# frozen_string_literal: true

require 'csv'

class MatchBatchImport < ApplicationRecord
  enum status: { pending: 0, processing: 1, done: 2, failed: 3 }

  has_one_attached :csv

  validates :csv, attached: true, content_type: 'text/csv'

  def import_matches!
    with_lock do
      return unless pending? # rubocop:todo Rails/TransactionExitStatement

      processing!

      transaction do
        process_csv
      end

      done!
    rescue ActiveRecord::RecordInvalid
      failed!
    end
  end

  private

  def process_csv
    CSV.parse(csv.download, headers: true) do |row|
      create_match(row)
    end
  end

  def create_match(row)
    Match.create!(home_team_id: Integer(row['home_team_id']), away_team_id: Integer(row['away_team_id']),
      home_team_goals: Integer(row['home_team_goals']), away_team_goals: Integer(row['away_team_goals']),
      start_at: DateTime.parse(row['start_at']), finished_at: DateTime.parse(row['finished_at']),
      stage_id: Integer(row['stage_id']))
  end
end
