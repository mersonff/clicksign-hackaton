# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MatchImportJob do
  describe '#perform_now' do
    before do
      create_list(:stage, 7)
      create_list(:team, 32)
    end

    context 'with a correct csv file' do
      let(:batch) { create(:match_batch_import, :with_attachment) }

      it 'marks batch as done', :aggregate_failures do
        expect(batch.pending?).to be(true)

        described_class.perform_now(batch.id)

        expect(batch.reload.done?).to be(true)
        expect(Match.count).to be > 0
      end
    end

    context 'with a incorrect csv file' do
      let(:batch) { create(:match_batch_import, :with_wrong_attachment) }

      it 'marks batch as failed', :aggregate_failures do
        expect(batch.pending?).to be(true)

        described_class.perform_now(batch.id)

        expect(batch.reload.failed?).to be(true)
        expect(Match.count).to be(0)
      end
    end

    context 'with a incorrect status' do
      let(:batch) { create(:match_batch_import, :with_attachment, status: :processing) }

      it 'marks batch as failed', :aggregate_failures do
        expect(batch.processing?).to be(true)

        described_class.perform_now(batch.id)

        expect(batch.reload.processing?).to be(true)
        expect(Match.count).to be(0)
      end
    end
  end
end
