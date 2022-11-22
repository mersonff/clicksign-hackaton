# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Teams' do
  let(:user) { create(:user) }
  let(:headers) { { Authorization: "Bearer #{jwt_and_refresh_token(user, 'user').first}" } }

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
    let(:request) { post teams_path, params: params, headers: headers, as: :multipart_form }

    describe 'when success' do
      let(:params) do
        {
          name: 'Brazil',
          description: 'Lorem ipsum dolor',
          flag: fixture_file_upload('br.png', 'image/png')
        }
      end

      it 'creates new team with attached flag', :aggregate_failures do
        request
        expect(response).to have_http_status(:created)
        expect(Team.last.flag.attached?).to be(true)
      end
    end

    describe 'when fail' do
      let(:params) do
        {
          name: nil,
          description: nil
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
      let(:params) { { name: 'Real Madrid Club de Fútbol' } }

      it do
        request
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'when fail' do
      let(:params) { { name: nil } }

      it do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /teams/:id' do
    let(:team) { create(:team) }
    let(:request) { delete team_path(team), headers: headers, as: :json }

    context 'when success' do
      it do
        request
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when fail' do
      before do
        create(:match, home_team: team)
      end

      it do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
