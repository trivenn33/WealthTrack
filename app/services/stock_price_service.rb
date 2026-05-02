require 'net/http'
require 'json'

class StockPriceService
    BASE_URL = "https://www.alphavantage.co/query"

    def self.fetch_price(symbol)
        api_key = ENV['ALPHA_VANTAGE_KEY']
        url = URI(BASE_URL)
        params = {
            function: "GLOBAL_QUOTE",
            symbol: symbol,
            apikey: api_key
        }
        url.query = URI.encode_www_form(params)
        response = Net::HTTP.get_response(url)
        data = JSON.parse(response.body)
        price = data.dig("Global Quote", "05. price")
        return price ? price.to_f : nil
    end
end