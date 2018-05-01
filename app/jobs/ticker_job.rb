class TickerJob < ApplicationJob
  queue_as :default

  def perform
    CryptoService.ticker
  end
end
