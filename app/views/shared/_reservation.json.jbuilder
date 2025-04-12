json.extract! reservation, :id, :seat_number, :created_at, :updated_at
json.showtime do
  json.partial! 'shared/showtime', showtime: reservation.showtime
end 