# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stage do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
