class MatchBatchImportController < ApplicationController

  def batch_import
    @batch = MatchBatchImport.new(
      csv: params[:csv]
    )

    if @batch.save
      MatchImportJob.perform_later @batch.id
      render json: { batch: @batch.id }, status: :created
    else
      render json: { error: 'Could not queue batch' }, status: :unprocessable_entity
    end
  end
end
