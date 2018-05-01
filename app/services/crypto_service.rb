require 'net/http'

class CryptoService
  API_URL = 'https://api.coinmarketcap.com/v2/ticker/'

  def self.ticker
    uri = URI(API_URL)
    response = Net::HTTP.get(uri)

    coins_data = JSON.parse(response)['data'].values

    coins_data.each do |coin_data|
      coin = Coin.find_or_create_from_service(coin_data)

      coin.create_tick(coin_data['quotes']['USD'].merge('rank' => coin_data['rank']))
    end
  end
end
