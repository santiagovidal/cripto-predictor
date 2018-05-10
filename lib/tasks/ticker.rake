task ticker: :environment do
  CryptoService.ticker
  Tick.delete_old_ticks
end
