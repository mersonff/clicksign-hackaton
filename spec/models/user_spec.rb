# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to have_db_index(:email) }

    context 'when valid' do
      let(:user) { build(:user) }

      it :aggregate_failures do
        expect(user).to be_valid
        expect(user.save).to be(true)
      end
    end

    context 'when invalid' do
      let(:user) { build(:user, email: 'email') }

      it :aggregate_failures do
        expect(user).not_to be_valid
        expect(user.save).to be(false)
      end
    end
  end
end
