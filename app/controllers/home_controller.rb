class HomeController < ApplicationController

  def index
    @hourly_top_ticks = Tick.hourly_top.with_coin
    @daily_top_ticks = Tick.daily_top.with_coin
    @weekly_top_ticks = Tick.weekly_top.with_coin
  end
end
