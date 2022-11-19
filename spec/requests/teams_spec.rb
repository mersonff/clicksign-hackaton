# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teams', type: :request do
  let(:user) { create(:user) }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:headers) { { Authorization: "Bearer #{token.first}" } }

  describe 'GET /teams/' do
    let(:request) { get teams_path, headers: headers, as: :json }

    before do
      create_list(:team, 2)
    end

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /teams/:id' do
    let(:team) { create(:team) }
    let(:request) { get team_path(team), headers: headers, as: :json }

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /teams' do
    let(:request) { post teams_path, params: params, headers: headers, as: :json }

    describe 'when success' do
      let(:params) do
        {
          team: {
            name: 'Real Madrid Club de Fútbol',
            description: 'Lorem ipsum dolor'
          }
        }
      end

      it do
        request
        expect(response).to have_http_status(:created)
      end
    end

    describe 'when fail' do
      let(:params) do
        {
          team: {
            name: nil,
            description: nil
          }
        }
      end

      it do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /teams/:id' do
    let(:team) { create(:team) }
    let(:request) { patch team_path(team), params: params, headers: headers, as: :json }

    describe 'when success' do
      let(:params) { { team: { name: 'Real Madrid Club de Fútbol' } } }

      it do
        request
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'when fail' do
      let(:params) { { team: { name: nil } } }

      it do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /teams/:id' do
    let(:team) { create(:team) }
    let(:request) { delete team_path(team), headers: headers, as: :json }

    it do
      request
      expect(response).to have_http_status(:ok)
    end
  end
end
