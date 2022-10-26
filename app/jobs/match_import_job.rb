class MatchImportJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    puts 'MatchImportJob worker'
  end
end
