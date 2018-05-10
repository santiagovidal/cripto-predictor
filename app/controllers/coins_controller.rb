class CoinsController < ApplicationController
  helper_method :coin

  def show
  end

  private

  def coin
    @coin ||= Coin.find(params[:id])
  end
end
