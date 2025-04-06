class MovieRoom < ApplicationRecord
  validates :number, presence: true, uniqueness: true, numericality: { greater_than: 0 }
  validates :total_seats, presence: true, numericality: { greater_than: 0 }
end 