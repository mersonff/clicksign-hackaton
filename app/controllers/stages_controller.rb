class StagesController < ApplicationController
  def create
    @stage = Stage.new(stages_params)

    if @stage.save
      head :created
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
end
