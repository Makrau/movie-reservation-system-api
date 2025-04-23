class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations, id: :uuid do |t|
      t.references :showtime, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :seat_number, null: false

      t.timestamps
    end

    add_index :reservations, [ :showtime_id, :seat_number ], unique: true
  end
end
