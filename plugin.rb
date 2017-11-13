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

after_initialize do

  require_dependency 'list_controller'
  class ::ListController
    def cryptocurrencies
      render "default/empty"
    end
  end

end