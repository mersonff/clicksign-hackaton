# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/matches', type: :request do
  let(:valid_attributes) do
    {
      home_team: create(:team),
      away_team: create(:team),
      home_team_goals: 0,
      away_team_goals: 0,
      start_at: Time.zone.now,
      finished_at: Time.zone.now + 90.minutes,
      current_time: Time.zone.now + 10.minutes,
      stage: create(:stage)
    }
  end

  let(:invalid_attributes) do
    {
      home_team: create(:team),
      away_team: create(:team),
      home_team_goals: -1,
      away_team_goals: -1,
      start_at: Time.zone.now,
      finished_at: Time.zone.now + 90.minutes,
      current_time: Time.zone.now + 10.minutes,
      stage: create(:stage)
    }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Match.create! valid_attributes
      get matches_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      match = Match.create! valid_attributes
      get match_url(match), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Match' do
        expect do
          post matches_url, params: { match: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Match, :count).by(1)
      end

      it 'renders a JSON response with the new match' do
        post matches_url,
             params: { match: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Match' do
        expect do
          post matches_url, params: { match: invalid_attributes }, as: :json
        end.to change(Match, :count).by(0)
      end

      it 'renders a JSON response with errors for the new match' do
        post matches_url, params: { match: invalid_attributes }, headers: valid_headers, as: :json
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

      it 'updates the requested match' do
        match = Match.create! valid_attributes
        patch match_url(match), params: { match: new_attributes }, headers: valid_headers, as: :json
        match.reload
        skip('Add assertions for updated state')
      end

      it 'renders a JSON response with the match' do
        match = Match.create! valid_attributes
        patch match_url(match), params: { match: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the match' do
        match = Match.create! valid_attributes
        patch match_url(match),
              params: { match: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested match' do
      match = Match.create! valid_attributes
      expect do
        delete match_url(match), headers: valid_headers, as: :json
      end.to change(Match, :count).by(-1)
    end
  end
end
