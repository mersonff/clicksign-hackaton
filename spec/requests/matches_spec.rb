# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/matches', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { Authorization: "Bearer #{jwt_and_refresh_token(user, 'user').first}" } }
  let(:valid_attributes) do
    {
      home_team_id: create(:team).id,
      away_team_id: create(:team).id,
      home_team_goals: 0,
      away_team_goals: 0,
      start_at: Time.current,
      finished_at: 90.minutes.from_now,
      stage_id: create(:stage).id
    }
  end

  let(:invalid_attributes) do
    {
      home_team: create(:team),
      away_team: create(:team),
      home_team_goals: -1,
      away_team_goals: -1,
      start_at: Time.current,
      finished_at: 90.minutes.from_now,
      stage: create(:stage)
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Match.create! valid_attributes
      get matches_url, headers: headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    let!(:match) { create(:match) }

    it 'renders a successful response' do
      get match_url(match), headers: headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Match' do
        expect do
          post matches_url, params: { match: valid_attributes }, headers: headers, as: :json
        end.to change(Match, :count).by(1)
      end

      it 'renders a JSON response with the new match', :aggregate_failures do
        post matches_url,
          params: { match: valid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Match' do
        expect do
          post matches_url, params: { match: invalid_attributes }, as: :json
        end.not_to change(Match, :count)
      end

      it 'renders a JSON response with errors for the new match', :aggregate_failures do
        post matches_url, params: { match: invalid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          home_team_goals: 1,
          away_team_goals: 0
        }
      end

      it 'updates the requested match', :aggregate_failures do
        match = Match.create! valid_attributes

        patch match_url(match), params: { match: new_attributes }, headers: headers, as: :json
        match.reload

        expect(response).to have_http_status(:ok)
        expect(match.home_team_goals).to eq(1)
      end

      it 'renders a JSON response with the match', :aggregate_failures do
        match = Match.create! valid_attributes
        patch match_url(match), params: { match: new_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      let!(:match) { create(:match) }

      it 'renders a JSON response with errors for the match' do
        patch match_url(match),
          params: { match: invalid_attributes }, headers: headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:match) { create(:match) }

    it 'destroys the requested match' do
      expect do
        delete match_url(match), headers: headers, as: :json
      end.to change(Match, :count).by(-1)
    end
  end
end
