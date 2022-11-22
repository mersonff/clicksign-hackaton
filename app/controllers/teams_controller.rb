# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: %i[update show destroy]

  def index
    @teams = Team.all
  end

  def show
    @team
  end

  def create
    @team = Team.new(teams_params)

    if @team.save
      head :created
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(teams_params)
      head :ok
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @team = Team.find(params[:id])

    head :ok if @team.destroy
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def teams_params
    params.permit(:name, :description, :flag)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
