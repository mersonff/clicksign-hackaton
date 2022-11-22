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
      # travel_to DateTime.current + 100.minutes
      described_class.update_matches!
    end

    it :aggregate_failures do
      expect(UpdateMatchesJob).to have_been_enqueued
      expect do
        ActionCable.server.broadcast 'matches_channel', { match: matches.first }
      end.to have_broadcasted_to('matches_channel')
    end
  end

  describe '#unfinished' do
    context 'when previous match' do
      let(:previoes_match) { create(:match) }

      before do
        travel_to(2.hours.ago)
        previoes_match
        travel_back
      end

      it do
        expect(described_class.unfinished).not_to include(previoes_match)
      end
    end

    context 'when current match' do
      let(:current_match) { create(:match) }

      before do
        travel_to(1.hour.ago)
        current_match
        travel_back
      end

      it do
        expect(described_class.unfinished).to include(current_match)
      end
    end

    context 'when next match' do
      let(:next_match) { create(:match) }

      before do
        travel_to(2.hours.from_now)
        next_match
        travel_back
      end

      it do
        expect(described_class.unfinished).not_to include(next_match)
      end
    end
  end

  describe '#increment_goals' do
    let(:match) { create(:match, updated_at: DateTime.current - 1.day) }
    let(:goals_sample) { 1 }

    it 'increments goals' do
      expect(described_class.public_send(:increment_goals, match)).to be_truthy
    end
  end

  describe '#match_format' do
    let(:match) { create(:match) }
    let(:match_format_return) { described_class.match_format(match) }

    it :aggregate_failures do
      expect(match_format_return[:home]).to eq(match.home_team.name)
      expect(match_format_return[:away]).to eq(match.away_team.name)
    end
  end
end
