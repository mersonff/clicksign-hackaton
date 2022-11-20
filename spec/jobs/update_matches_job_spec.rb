# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMatchesJob do
  include ActiveJob::TestHelper

  describe '#perform_now' do
    let(:matches) { create_list(:match, 10, start_at: DateTime.current, finished_at: nil) }

    before do
      clear_enqueued_jobs
    end

    context 'when called' do
      before do
        matches
        travel(100.minutes)
        described_class.perform_now
      end

      it :aggregate_failures do
        expect(matches.first.reload.finished_at).not_to be_nil
        expect(described_class).to have_been_enqueued
      end
    end
  end
end
