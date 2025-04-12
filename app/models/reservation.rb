class Reservation < ApplicationRecord
  belongs_to :showtime
  belongs_to :user

  validates :seat_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :seat_number_within_room_capacity
  validate :seat_not_already_taken

  private

  def seat_number_within_room_capacity
    return if seat_number.blank? || showtime.blank? || showtime.movie_room.blank?
    if seat_number > showtime.movie_room.total_seats
      errors.add(:seat_number, "exceeds room capacity")
    end
  end

  def seat_not_already_taken
    return if seat_number.blank? || showtime.blank?
    if showtime.reservations.where(seat_number: seat_number).where.not(id: id).exists?
      errors.add(:seat_number, "is already taken for this showtime")
    end
  end
end 