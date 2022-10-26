class MatchBatchImport < ApplicationRecord
  enum status: { pending: 0, processing: 1, done: 2, failed: 3 }

  has_one_attached :csv

  validates :csv, attached: true, content_type: 'text/csv'
end
