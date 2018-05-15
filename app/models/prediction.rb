# == Schema Information
#
# Table name: predictions
#
#  id                   :integer          not null, primary key
#  coin_id              :integer
#  tick_id              :integer
#  timeframe            :date
#  original_price       :float
#  highest_price_so_far :float
#  successful           :boolean          default("false")
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_predictions_on_coin_id  (coin_id)
#  index_predictions_on_tick_id  (tick_id)
#

class Prediction < ApplicationRecord
  PREDICTION_DAYS = 5
  CONSECUTIVE_DAILY_VOLUMES = 5

  belongs_to :coin
  belongs_to :responsible_tick, class_name: 'Tick', foreign_key: :tick_id

  before_validation :set_timeframe
  validates :timeframe, :original_price, :highest_price_so_far, presence: true

  scope :active, -> { where('timeframe > ?', Time.zone.now) }

  def update_price_so_far(price)
    update!(highest_price_so_far: price) if price > highest_price_so_far
  end

  def change_so_far
    ((highest_price_so_far - original_price)/original_price)*100
  end

  def self.create_if_conditions_match(tick)
    # Condition: if daily volume grows for 5 ticks (hours in a row)

    coin = tick.coin
    last_daily_volumes = coin.ticks.order_desc.limit(CONSECUTIVE_DAILY_VOLUMES).pluck(:daily_volume)

    if last_daily_volumes.sort.reverse == last_daily_volumes
      create!(responsible_tick: tick, coin: coin, original_price: tick.price, highest_price_so_far: tick.price)
    end
  end

  private

  def set_timeframe
    self.timeframe = PREDICTION_DAYS.days.from_now
  end
end
