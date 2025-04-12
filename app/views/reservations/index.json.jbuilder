json.array! @reservations do |reservation|
  json.partial! 'shared/reservation', reservation: reservation
end 