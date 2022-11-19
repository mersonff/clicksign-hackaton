# frozen_string_literal: true

class MatchImportJob < ApplicationJob
  queue_as :default

  def perform(batch_id)
    MatchBatchImport.find(batch_id).import_matches!
  end
end
