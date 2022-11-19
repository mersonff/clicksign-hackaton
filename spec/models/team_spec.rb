# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team do
  describe 'validations' do
    it { is_expected.to have_one_attached(:flag) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }

    context 'with valid attributes' do
      let(:team) { build(:team) }

      it { expect(team).to be_valid }
      it { expect(team.save).to be(true) }
    end

    context 'without name' do
      let(:team) { build(:team, name: nil) }

      it { expect(team).not_to be_valid }
      it { expect(team.save).to be(false) }
    end

    context 'with same name twice' do
      before { create(:team, name: 'Brazil') }

      let(:second_team) { build(:team, name: 'Brazil') }

      it { expect(second_team).not_to be_valid }
    end
  end
end
