# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match do
  include ActiveJob::TestHelper

  it { is_expected.to belong_to(:home_team).class_name('Team') }
  it { is_expected.to belong_to(:away_team).class_name('Team') }
  it { is_expected.to belong_to(:stage) }
  it { is_expected.to validate_numericality_of(:home_team_goals).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_numericality_of(:away_team_goals).is_greater_than_or_equal_to(0) }
  it { is_expected.to validate_presence_of(:home_team_goals) }
  it { is_expected.to validate_presence_of(:away_team_goals) }
  it { is_expected.to validate_presence_of(:start_at) }

  describe 'home team and away team cannot be the same' do
    let(:team) { create(:team) }
    let(:match) { build(:match, home_team: team, away_team: team) }

    it 'is invalid' do
      expect(match).not_to be_valid
    end
  end

  describe '#update_matches!' do
    let(:matches) { create_list(:match, 3, start_at: DateTime.current, finished_at: nil) }

    before do
      clear_enqueued_jobs
      matches
      travel_to DateTime.current + 100.minutes
      described_class.update_matches!
    end

    it :aggregate_failures do
      expect(matches.first.reload.finished_at).not_to be_nil
      expect(UpdateMatchesJob).to have_been_enqueued
      expect do
        ActionCable.server.broadcast 'matches_channel', { match: matches.first }
      end.to have_broadcasted_to('matches_channel')
    end
  end

  describe '#unfinished' do
    let(:finished_match) { create(:match, finished_at: DateTime.current) }
    let(:unfinished_match) { create(:match, finished_at: nil) }

    it 'returns only unfinished matches', :aggregate_failures do
      expect(described_class.unfinished).to include(unfinished_match)
      expect(described_class.unfinished).not_to include(finished_match)
    end
  end

  describe '#increment_goals' do
    let(:match) { create(:match, updated_at: DateTime.current - 1.day) }
    let(:goals_sample) { 1 }

    it 'increments goals' do
      expect(described_class.public_send(:increment_goals, match)).to be_truthy
    end
  end

  describe '#verify_if_is_finished' do
    let(:match) { create(:match, start_at: DateTime.current, finished_at: nil) }

    before do
      match
      travel(100.minutes)
      described_class.public_send(:verify_if_is_finished, match)
    end

    it do
      expect(match.reload.finished_at).not_to be_nil
    end
  end
end
