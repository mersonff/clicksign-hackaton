# frozen_string_literal: true

class Team < ApplicationRecord
  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true

  validates :name, uniqueness: true
end
