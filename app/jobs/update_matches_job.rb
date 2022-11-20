# frozen_string_literal: true

class UpdateMatchesJob < ApplicationJob
  queue_as :default

  def perform
    Match.update_matches!
  end
end
