class Showtime < ApplicationRecord
  belongs_to :movie
  belongs_to :movie_room
  has_many :reservations, dependent: :destroy

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_after_start_time
  validate :no_overlapping_showtimes

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def no_overlapping_showtimes
    return if start_time.blank? || end_time.blank? || movie_room_id.blank?

    overlapping = Showtime.where(movie_room_id: movie_room_id)
                         .where.not(id: id)
                         .where("(start_time, end_time) OVERLAPS (?, ?)", start_time, end_time)
                         .exists?

    if overlapping
      errors.add(:base, "Showtime overlaps with another showtime in the same room")
    end
  end
end 