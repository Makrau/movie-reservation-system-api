class Seat < ApplicationRecord
  belongs_to :movie_room
  has_many :reservations

  validates :row_number, presence: true, numericality: { greater_than: 0 }
  validates :column_number, presence: true, numericality: { greater_than: 0 }
  validates :label, presence: true, uniqueness: { scope: :movie_room_id }
  validates :seat_type, inclusion: { in: %w[regular wheelchair couple] }

  validate :unique_position_in_room

  private

  def unique_position_in_room
    return if movie_room_id.blank? || row_number.blank? || column_number.blank?

    if Seat.where(movie_room_id: movie_room_id,
                 row_number: row_number,
                 column_number: column_number)
          .where.not(id: id)
          .exists?
      errors.add(:base, "Já existe um assento nesta posição")
    end
  end
end
