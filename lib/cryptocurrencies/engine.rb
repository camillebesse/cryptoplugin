require 'net/http'
require 'json'

module Cryptocurrencies
  class Engine < ::Rails::Engine
    isolate_namespace Cryptocurrencies

    config.after_initialize do

      module ::Jobs
        class PollCoinMarketCap < Jobs::Scheduled
          every 5.minutes

          def execute(args)

            uri = URI("https://api.coinmarketcap.com/v1/ticker/")
            response = Net::HTTP.get(uri)
            json = JSON.parse(response)

            json.each do |currency|
              puts currency["id"]
            end

          end

        end
      end

    end
  end
end