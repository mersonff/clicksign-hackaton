# frozen_string_literal: true

class StagesController < ApplicationController
  before_action :set_stage, only: %i[show update destroy]

  def index
    @stages = Stage.all
  end

  def show
    @stage
  end

  def create
    @stage = Stage.new(stages_params)

    if @stage.save
      head :created
    else
      render json: @stage.errors, status: :unprocessable_entity
    end
  end

  def update
    if @stage.update(stages_params)
      head :ok
    else
      render json: @stage.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @stage = Stage.find(params[:id])

    if @stage.destroy
      head :ok
    else
      render json: @stage.errors, status: :unprocessable_entity
    end
  end

  private

  def stages_params
    params.require(:stage).permit(:name)
  end

  def set_stage
    @stage = Stage.find(params[:id])
  end
end
