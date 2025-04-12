json.array! @showtimes do |showtime|
  json.partial! 'shared/showtime', showtime: showtime
end 