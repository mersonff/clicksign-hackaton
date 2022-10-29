require 'rails_helper'

RSpec.describe 'Stages', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:headers) { { Authorization: "Bearer #{token.first}" } }

  describe 'GET /stages/' do
    let(:request) { get stages_path, headers: headers }

    before do
      2.times do
        create(:stage)
      end
    end

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /stages/:id' do
    let(:stage) { create(:stage) }
    let(:request) { get stage_path(stage), headers: headers }

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /stages' do
    let(:request) { post stages_path, params: params, headers: headers }

    describe 'when success' do
      let(:params) { { stage: { name: 'Oitavas de final' } } }

      it do
        request
        expect(response).to have_http_status(:created)
      end
    end

    describe 'when fail' do
      let(:params) { { stage: { name: nil } } }

      it do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /stages/:id' do
    let(:stage) { create(:stage) }
    let(:request) { patch stage_path(stage.id), params: params, headers: headers }

    describe 'when success' do
      let(:params) { { stage: { name: 'Oitavas de final' } } }

      it do
        request
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'when success' do
      let(:params) { { stage: { name: nil } } }

      it do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /stages/:id' do
    let(:stage) { create(:stage) }
    let(:request) { delete stage_path(stage), headers: headers }

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end
end
