# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stages' do
  let(:user) { create(:user) }
  let(:headers) { { Authorization: "Bearer #{jwt_and_refresh_token(user, 'user').first}" } }

  describe 'GET /stages/' do
    let(:request) { get stages_path, headers: headers, as: :json }

    before do
      create_list(:stage, 2)
    end

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /stages/:id' do
    let(:stage) { create(:stage) }
    let(:request) { get stage_path(stage), headers: headers, as: :json }

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /stages' do
    let(:request) { post stages_path, params: params, headers: headers, as: :json }

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
    let(:request) { patch stage_path(stage.id), params: params, headers: headers, as: :json }

    describe 'when success' do
      let(:params) { { stage: { name: 'Oitavas de final' } } }

      it do
        request
        expect(response).to have_http_status(:ok)
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

  describe 'DELETE /stages/:id' do
    let(:stage) { create(:stage) }
    let(:request) { delete stage_path(stage), headers: headers, as: :json }

    context 'when success' do
      it do
        request
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fail' do
      before do
        create(:match, stage: stage)
      end

      it do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
