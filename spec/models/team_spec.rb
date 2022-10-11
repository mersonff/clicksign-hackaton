# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validations' do
    context 'with valid attributes' do
      let(:team) { build(:team) }

      it { expect(team).to be_valid }
      it { expect(team.save).to be(true) }
    end

    context 'without name' do
      let(:team) { build(:team, name: nil) }

      it { expect(team).to_not be_valid }
      it { expect(team.save).to be(false) }
    end

    context 'without a description' do
      let(:team) { build(:team, description: nil) }

      it { expect(team).to_not be_valid }
      it { expect(team.save).to be(false) }
    end

    context 'with same name twice' do
      before { create(:team) }
      let(:second_team) { build(:team, name: 'Brazil') }

      it { expect(second_team).to_not be_valid }
    end
  end
end