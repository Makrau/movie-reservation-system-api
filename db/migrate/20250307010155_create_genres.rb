class CreateGenres < ActiveRecord::Migration[8.0]
  def change
    create_table :genres, id: :uuid do |t|
      t.string :genre, null: false

      t.timestamps

      t.index :genre, unique: true
    end
  end
end
