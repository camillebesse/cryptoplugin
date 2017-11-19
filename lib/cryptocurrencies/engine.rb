require 'net/http'
require 'json'

module Cryptocurrencies
  class Engine < ::Rails::Engine
    isolate_namespace Cryptocurrencies

    config.after_initialize do

      # SiteSetting.top_menu = "home|latest|new|unread|top|categories"

      module ::Jobs
        class PollCoinMarketCap < Jobs::Scheduled
          every 5.minutes

          def execute(args)

            if SiteSetting.cryptocurrencies_enabled
              t = Time.new.to_i
              uri = URI("https://api.coinmarketcap.com/v1/ticker/?limit=999999&t=" + t.to_s)
              response = Net::HTTP.get(uri)
              json = JSON.parse(response)

              json.each do |currency|

                topic_cfs = TopicCustomField.where(name: "cryptocurrency_id", value: currency["id"])
                if topic_cfs.empty?
                  user = User.find_by(username_lower: SiteSetting.cryptocurrencies_new_topic_owner.downcase)
                  category = SiteSetting.cryptocurrencies_new_topic_category
                  raw = '<div class="hidden-cryptocurrency-content-' + currency["name"] + '"></div>'
                  t = PostCreator.create(
                                user,
                                title: currency["name"],
                                category: category,
                                raw: raw
                              )
                  if t
                    topic = Topic.find(t.topic_id)
                  end
                else
                  topic = Topic.find(topic_cfs[0].topic_id)
                end

                if topic
                  topic.custom_fields["cryptocurrency_id"] = currency["id"]
                  topic.custom_fields["cryptocurrency_name"] = currency["name"]
                  topic.custom_fields["cryptocurrency_symbol"] = currency["symbol"]
                  topic.custom_fields["cryptocurrency_rank"] = currency["rank"]
                  topic.custom_fields["cryptocurrency_price_usd"] = currency["price_usd"]
                  topic.custom_fields["cryptocurrency_price_btc"] = currency["price_btc"]
                  topic.custom_fields["cryptocurrency_24h_volume_usd"] = currency["24h_volume_usd"]
                  topic.custom_fields["cryptocurrency_market_cap_usd"] = currency["market_cap_usd"]
                  topic.custom_fields["cryptocurrency_available_supply"] = currency["available_supply"]
                  topic.custom_fields["cryptocurrency_total_supply"] = currency["total_supply"]
                  topic.custom_fields["cryptocurrency_max_supply"] = currency["max_supply"]
                  topic.custom_fields["cryptocurrency_percent_change_1h"] = currency["percent_change_1h"]
                  topic.custom_fields["cryptocurrency_percent_change_24h"] = currency["percent_change_24h"]
                  topic.custom_fields["cryptocurrency_percent_change_7d"] = currency["percent_change_7d"]
                  topic.custom_fields["cryptocurrency_last_updated"] = currency["last_updated"]

                  topic.custom_fields["cryptocurrency_price_usd_sort"] = currency["price_usd"].to_i
                  topic.custom_fields["cryptocurrency_price_btc_sort"] = currency["price_btc"].to_i
                  topic.custom_fields["cryptocurrency_24h_volume_usd_sort"] = currency["24h_volume_usd"].to_i
                  topic.custom_fields["cryptocurrency_market_cap_usd_sort"] = currency["market_cap_usd"].to_i
                  topic.custom_fields["cryptocurrency_available_supply_sort"] = currency["available_supply"].to_i
                  topic.custom_fields["cryptocurrency_total_supply_sort"] = currency["total_supply"].to_i
                  topic.custom_fields["cryptocurrency_max_supply_sort"] = currency["max_supply"].to_i
                  topic.custom_fields["cryptocurrency_percent_change_1h_sort"] = currency["percent_change_1h"].to_i
                  topic.custom_fields["cryptocurrency_percent_change_24h_sort"] = currency["percent_change_24h"].to_i
                  topic.custom_fields["cryptocurrency_percent_change_7d_sort"] = currency["percent_change_7d"].to_i

                  topic.save
                end
              end
            end

          end

        end
      end

    end
  end
end