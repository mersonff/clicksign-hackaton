# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MatchBatchImports', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:headers) { { Authorization: "Bearer #{token.first}" } }

  describe 'POST /matches/batch_import' do
    subject(:request) { post match_batch_import_path, params: params, headers: headers, as: :multipart_form }

    context 'with correct attachment' do
      let(:params) do
        {
          csv: fixture_file_upload('matches_01.csv', 'text/csv')
        }
      end

      it 'returns status 201 created' do
        request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new batch to be imported' do
        expect { request }.to change(MatchBatchImport, :count).by(1)
      end

      it 'enqueues a job to process the csv' do
        expect { request }.to have_enqueued_job(MatchImportJob)
      end
    end

    context 'without attachment' do
      let(:params) { {} }

      it 'returns status unprocessable_entity' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
