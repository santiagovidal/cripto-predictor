class CreateTicks < ActiveRecord::Migration[5.2]
  def change
    create_table :ticks do |t|
      t.references :coin, foreign_key: true
      t.float :price
      t.float :daily_volume
      t.float :market_cap
      t.float :hourly_change
      t.float :daily_change
      t.float :weekly_change
      t.integer :rank

      t.timestamps
    end
  end
end
