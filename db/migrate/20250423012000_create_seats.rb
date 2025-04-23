class CreateSeats < ActiveRecord::Migration[8.0]
  def change
    create_table :seats, id: :uuid do |t|
      t.references :movie_room, null: false, foreign_key: true, type: :uuid
      t.integer :row_number, null: false
      t.integer :column_number, null: false
      t.string :label, null: false
      t.point :coordinates
      t.string :seat_type, null: false, default: 'regular'
      t.timestamps

      t.index [ :movie_room_id, :row_number, :column_number ], unique: true, name: 'idx_seats_position'
      t.index [ :movie_room_id, :label ], unique: true
    end

    remove_column :reservations, :seat_number
    add_reference :reservations, :seat, null: false, foreign_key: true, type: :uuid
    add_index :reservations, [ :showtime_id, :seat_id ], unique: true
  end
end
