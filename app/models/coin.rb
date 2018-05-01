# == Schema Information
#
# Table name: coins
#
#  id                 :integer          not null, primary key
#  name               :string
#  uid                :integer
#  symbol             :string
#  website_slug       :string
#  circulating_supply :float
#  total_supply       :float
#  max_supply         :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Coin < ApplicationRecord
  has_many :ticks

  validates :name, :uid, :symbol, :website_slug,
            :circulating_supply, :total_supply, presence: true

  def create_tick(data)
    ticks.create!(
      price: data['price'],
      daily_volume: data['volume_24h'],
      market_cap: data['market_cap'],
      hourly_change: data['percent_change_1h'],
      daily_change: data['percent_change_24h'],
      weekly_change: data['percent_change_7d'],
      rank: data['rank']
    )
  end

  def self.find_or_create_from_service(data)
    find_or_create_by!(uid: data['id']) do |coin|
      coin.name = data['name']
      coin.symbol = data['symbol']
      coin.website_slug = data['website_slug']
      coin.circulating_supply = data['circulating_supply']
      coin.total_supply = data['total_supply']
      coin.max_supply = data['max_supply']
    end
  end
end
