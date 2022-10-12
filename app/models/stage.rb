class Stage < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
