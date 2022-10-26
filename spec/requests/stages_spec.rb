require 'rails_helper'

RSpec.describe 'Stages', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:headers) { { Authorization: "Bearer #{token.first}" }}

  describe 'POST /stages' do
    let(:request) { post stages_path, params: params, headers: headers }
    let(:params) { { stage: { name: 'Oitavas de final' } } }

    it do
      request
      expect(response).to have_http_status(:created)
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
