# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  
  it { should belong_to(:home_team).class_name('Team') }
  it { should belong_to(:away_team).class_name('Team') }
  it { should belong_to(:stage) }
  it { should validate_numericality_of(:home_team_goals).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:away_team_goals).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:home_team) }
  it { should validate_presence_of(:away_team) }
  it { should validate_presence_of(:home_team_goals) }
  it { should validate_presence_of(:away_team_goals) }
  it { should validate_presence_of(:start_at) }

  describe 'home team and away team cannot be the same' do
    let(:team) { create(:team) }
    let(:match) { build(:match, home_team: team, away_team: team) }

    it 'is invalid' do
      byebug
      expect(match).to_not be_valid
    end
  end
end
