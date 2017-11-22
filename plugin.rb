# name: cryptoplugin
# about: Adds a custom homepage for cryptocurrencies
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://github.com/camillebesse/cryptoplugin

enabled_site_setting :cryptocurrencies_enabled

register_asset "stylesheets/cryptocurrencies.scss"

Discourse.top_menu_items.push(:home)
Discourse.anonymous_top_menu_items.push(:home)
Discourse.filters.push(:home)
Discourse.anonymous_filters.push(:home)

Discourse.top_menu_items.push(:favorites)
Discourse.anonymous_top_menu_items.push(:favorites)
Discourse.filters.push(:favorites)
Discourse.anonymous_filters.push(:favorites)

load File.expand_path('../lib/cryptocurrencies/engine.rb', __FILE__)

after_initialize do

  require_dependency 'topic_query'
  class ::TopicQuery
    SORTABLE_MAPPING["market_rank"] = "custom_fields.cryptocurrency_rank"
    SORTABLE_MAPPING["market_cap"] = "custom_fields.cryptocurrency_rank"
    SORTABLE_MAPPING["price_usd"] = "custom_fields.cryptocurrency_price_usd_sort"
    SORTABLE_MAPPING["24h_volume_usd"] = "custom_fields.cryptocurrency_24h_volume_usd_sort"
    SORTABLE_MAPPING["percent_change_1h"] = "custom_fields.cryptocurrency_percent_change_1h_sort"
    SORTABLE_MAPPING["percent_change_24h"] = "custom_fields.cryptocurrency_percent_change_24h_sort"
    SORTABLE_MAPPING["percent_change_7d"] = "custom_fields.cryptocurrency_percent_change_7d_sort"
    SORTABLE_MAPPING["cmc_link"] = "custom_fields.cryptocurrency_symbol_sort"

    def list_home
      create_list(:market_rank, unordered: true) do |topics|
        topics.joins("inner join topic_custom_fields tfv ON tfv.topic_id = topics.id AND tfv.name = 'cryptocurrency_rank'")
              .order("coalesce(tfv.value,'0')::integer asc, topics.bumped_at desc")
      end
    end

    def list_favorites
      create_list(:market_rank, unordered: true) do |topics|
        topics.joins("inner join topic_custom_fields tfv ON tfv.topic_id = topics.id AND tfv.name = 'cryptocurrency_rank'")
              .where('topics.id IN (SELECT pp.topic_id
                                FROM post_actions pa
                                JOIN posts pp ON pp.id = pa.post_id
                                WHERE pa.user_id = :user_id AND
                                      pa.post_action_type_id = :action AND
                                      pa.deleted_at IS NULL
                             )', user_id: @user.id,
                                 action: 1
                             )
              .order("coalesce(tfv.value,'0')::integer asc, topics.bumped_at desc")
      end
    end
  end

  require_dependency 'topic'
  class ::Topic
    def cryptocurrency_id
      if self.custom_fields["cryptocurrency_id"]
        self.custom_fields["cryptocurrency_id"]
      else
        nil
      end
    end

    def cryptocurrency_name
      if self.custom_fields["cryptocurrency_name"]
        self.custom_fields["cryptocurrency_name"]
      else
        nil
      end
    end

    def cryptocurrency_symbol
      if self.custom_fields["cryptocurrency_symbol"]
        self.custom_fields["cryptocurrency_symbol"]
      else
        nil
      end
    end

    def cryptocurrency_rank
      if self.custom_fields["cryptocurrency_rank"]
        self.custom_fields["cryptocurrency_rank"]
      else
        nil
      end
    end

    def cryptocurrency_price_usd
      if self.custom_fields["cryptocurrency_price_usd"]
        self.custom_fields["cryptocurrency_price_usd"]
      else
        nil
      end
    end

    def cryptocurrency_price_btc
      if self.custom_fields["cryptocurrency_price_btc"]
        self.custom_fields["cryptocurrency_price_btc"]
      else
        nil
      end
    end

    def cryptocurrency_24h_volume_usd
      if self.custom_fields["cryptocurrency_24h_volume_usd"]
        self.custom_fields["cryptocurrency_24h_volume_usd"]
      else
        nil
      end
    end

    def cryptocurrency_market_cap_usd
      if self.custom_fields["cryptocurrency_market_cap_usd"]
        self.custom_fields["cryptocurrency_market_cap_usd"]
      else
        nil
      end
    end

    def cryptocurrency_available_supply
      if self.custom_fields["cryptocurrency_available_supply"]
        self.custom_fields["cryptocurrency_available_supply"]
      else
        nil
      end
    end

    def cryptocurrency_total_supply
      if self.custom_fields["cryptocurrency_total_supply"]
        self.custom_fields["cryptocurrency_total_supply"]
      else
        nil
      end
    end

    def cryptocurrency_max_supply
      if self.custom_fields["cryptocurrency_max_supply"]
        self.custom_fields["cryptocurrency_max_supply"]
      else
        nil
      end
    end

    def cryptocurrency_percent_change_1h
      if self.custom_fields["cryptocurrency_percent_change_1h"]
        self.custom_fields["cryptocurrency_percent_change_1h"]
      else
        nil
      end
    end

    def cryptocurrency_percent_change_24h
      if self.custom_fields["cryptocurrency_percent_change_24h"]
        self.custom_fields["cryptocurrency_percent_change_24h"]
      else
        nil
      end
    end

    def cryptocurrency_percent_change_7d
      if self.custom_fields["cryptocurrency_percent_change_7d"]
        self.custom_fields["cryptocurrency_percent_change_7d"]
      else
        nil
      end
    end

    def cryptocurrency_last_updated
      if self.custom_fields["cryptocurrency_last_updated"]
        self.custom_fields["cryptocurrency_last_updated"]
      else
        nil
      end
    end

  end

  require_dependency 'topic_view_serializer'
  class ::TopicViewSerializer
    attributes :cryptocurrency_id, :cryptocurrency_name, :cryptocurrency_symbol, :cryptocurrency_rank, :cryptocurrency_price_usd, :cryptocurrency_price_btc, :cryptocurrency_24h_volume_usd, :cryptocurrency_market_cap_usd, :cryptocurrency_available_supply, :cryptocurrency_total_supply, :cryptocurrency_max_supply, :cryptocurrency_percent_change_1h, :cryptocurrency_percent_change_24h, :cryptocurrency_percent_change_7d, :cryptocurrency_last_updated

    def cryptocurrency_id
      object.topic.custom_fields["cryptocurrency_id"]
    end

    def cryptocurrency_name
      object.topic.custom_fields["cryptocurrency_name"]
    end

    def cryptocurrency_symbol
      object.topic.custom_fields["cryptocurrency_symbol"]
    end

    def cryptocurrency_rank
      object.topic.custom_fields["cryptocurrency_rank"]
    end

    def cryptocurrency_price_usd
      object.topic.custom_fields["cryptocurrency_price_usd"]
    end

    def cryptocurrency_price_btc
      object.topic.custom_fields["cryptocurrency_price_btc"]
    end

    def cryptocurrency_24h_volume_usd
      object.topic.custom_fields["cryptocurrency_24h_volume_usd"]
    end

    def cryptocurrency_market_cap_usd
      object.topic.custom_fields["cryptocurrency_market_cap_usd"]
    end

    def cryptocurrency_available_supply
      object.topic.custom_fields["cryptocurrency_available_supply"]
    end

    def cryptocurrency_total_supply
      object.topic.custom_fields["cryptocurrency_total_supply"]
    end

    def cryptocurrency_max_supply
      object.topic.custom_fields["cryptocurrency_max_supply"]
    end

    def cryptocurrency_percent_change_1h
      object.topic.custom_fields["cryptocurrency_percent_change_1h"]
    end

    def cryptocurrency_percent_change_24h
      object.topic.custom_fields["cryptocurrency_percent_change_24h"]
    end

    def cryptocurrency_percent_change_7d
      object.topic.custom_fields["cryptocurrency_percent_change_7d"]
    end

    def cryptocurrency_last_updated
      object.topic.custom_fields["cryptocurrency_last_updated"]
    end

  end

  add_to_serializer(:topic_list_item, :cryptocurrency_id) { object.custom_fields["cryptocurrency_id"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_name) { object.custom_fields["cryptocurrency_name"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_symbol) { object.custom_fields["cryptocurrency_symbol"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_rank) { object.custom_fields["cryptocurrency_rank"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_price_usd) { object.custom_fields["cryptocurrency_price_usd"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_price_btc) { object.custom_fields["cryptocurrency_price_btc"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_24h_volume_usd) { object.custom_fields["cryptocurrency_24h_volume_usd"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_market_cap_usd) { object.custom_fields["cryptocurrency_market_cap_usd"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_available_supply) { object.custom_fields["cryptocurrency_available_supply"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_total_supply) { object.custom_fields["cryptocurrency_total_supply"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_max_supply) { object.custom_fields["cryptocurrency_max_supply"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_percent_change_1h) { object.custom_fields["cryptocurrency_percent_change_1h"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_percent_change_24h) { object.custom_fields["cryptocurrency_percent_change_24h"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_percent_change_7d) { object.custom_fields["cryptocurrency_percent_change_7d"] }
  add_to_serializer(:topic_list_item, :cryptocurrency_last_updated) { object.custom_fields["cryptocurrency_last_updated"] }

  add_to_serializer(:topic_list_item, :topic_post_id) { object.first_post.id }
  add_to_serializer(:topic_list_item, :topic_post_bookmarked) { object.first_post.post_actions.exists?(post_action_type_id: 1) }

  add_to_serializer(:post, :topic_custom_fields, false) { object.topic.custom_fields }

end