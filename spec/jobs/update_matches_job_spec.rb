# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMatchesJob do
  include ActiveJob::TestHelper

  describe '#perform_now' do
    let(:matches) { create_list(:match, 10) }

    before do
      clear_enqueued_jobs
    end

    context 'when called' do
      before do
        matches
        described_class.perform_now
      end

      it :aggregate_failures do
        expect(described_class).to have_been_enqueued
      end
    end
  end
end
