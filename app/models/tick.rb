# == Schema Information
#
# Table name: ticks
#
#  id            :integer          not null, primary key
#  coin_id       :integer
#  price         :float
#  daily_volume  :float
#  market_cap    :float
#  hourly_change :float
#  daily_change  :float
#  weekly_change :float
#  rank          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_ticks_on_coin_id  (coin_id)
#

class Tick < ApplicationRecord
  belongs_to :coin

  validates :price, :daily_volume, :market_cap, :hourly_change,
            :daily_change, :weekly_change, :rank, presence: true

  scope :latest, -> { where(id: Tick.order(id: :desc).limit(100)) }
  scope :with_coin, -> { includes(:coin) }

  scope :hourly_top, -> { latest.order(hourly_change: :desc).limit(10) }
  scope :daily_top, -> { latest.order(daily_change: :desc).limit(10) }
  scope :weekly_top, -> { latest.order(weekly_change: :desc).limit(10) }
end
