# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: %i[update show destroy]

  def index
    @teams = Team.all

    render json: @teams
  end

  def show
    render json: @team
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

    if @team.destroy
      head :ok
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  private

  def teams_params
    params.require(:team).permit(:name, :description)
  end

  def set_team
    @team = Team.find(params[:id])
  end
end
