# frozen_string_literal: true

# Controller for Matches
class MatchesController < ApplicationController
  before_action :set_match, only: %i[show update destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show; end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)
    if @match.save
      render :show, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1
  # PATCH/PUT /matches/1.json
  def update
    if @match.update(match_params)
      render :show, status: :ok, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    @match.destroy!
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(
      :home_team_id, :away_team_id, :home_team_goals,
      :away_team_goals, :start_at, :finished_at, :current_time, :stage_id
    )
  end
end
