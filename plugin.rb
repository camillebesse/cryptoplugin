# name: cryptoplugin
# about: Adds a custom homepage for cryptocurrencies
# version: 0.1
# author: Joe Buhlig joebuhlig.com
# url: https://github.com/camillebesse/cryptoplugin

enabled_site_setting :cryptocurrencies_enabled

register_asset "stylesheets/cryptocurrencies.scss"

Discourse.top_menu_items.push(:cryptocurrencies)
Discourse.anonymous_top_menu_items.push(:cryptocurrencies)
Discourse.filters.push(:cryptocurrencies)
Discourse.anonymous_filters.push(:cryptocurrencies)

load File.expand_path('../lib/cryptocurrencies/engine.rb', __FILE__)

Onebox = Onebox

class Onebox::Engine::CoinMarketCapOnebox
  include Onebox::Engine
  
  REGEX = /^https?:\/\/coinmarketcap.com\/currencies\/(\w+)/
  matches_regexp REGEX

  def id
    @url.match(REGEX)[1]
  end
  
  def to_html
    "<div class=\"coinmarketcap-currency-widget\" data-currency=\"#{id}\" data-base=\"USD\" data-secondary=\"\" data-ticker=\"true\" data-rank=\"true\" data-marketcap=\"true\" data-volume=\"true\" data-stats=\"USD\" data-statsticker=\"false\"></div>"
  end
end

after_initialize do

  require_dependency 'list_controller'
  class ::ListController
    def cryptocurrencies
      render "default/empty"
    end
  end

end