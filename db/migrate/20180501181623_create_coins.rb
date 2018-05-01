class CreateCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :coins do |t|
      t.string :name
      t.integer :uid
      t.string :symbol
      t.string :website_slug
      t.float :circulating_supply
      t.float :total_supply
      t.float :max_supply

      t.timestamps
    end
  end
end
