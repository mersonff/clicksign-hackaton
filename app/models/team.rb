# frozen_string_literal: true

class Team < ApplicationRecord
  has_one_attached :flag

  validates :name, presence: true, uniqueness: true
end
