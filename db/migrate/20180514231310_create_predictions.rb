class CreatePredictions < ActiveRecord::Migration[5.2]
  def change
    create_table :predictions do |t|
      t.references :coin, foreign_key: true
      t.references :tick, foreign_key: true

      t.date :timeframe
      t.float :original_price
      t.float :highest_price_so_far
      t.boolean :successful, default: false

      t.timestamps
    end
  end
end
