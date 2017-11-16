import { withPluginApi } from 'discourse/lib/plugin-api';
import { default as computed, on, observes } from 'ember-addons/ember-computed-decorators';
import RawHtml from 'discourse/widgets/raw-html';

function initialize(api) {
  api.includePostAttributes('topic_custom_fields');

  api.decorateWidget('post-contents:after-cooked', dec => {

    if (dec.attrs.firstPost){
      const attrs = dec.attrs.topic_custom_fields;
      return [dec.h("div.cryptocurrency-custom-widget", [
          dec.h('div.crypto-widget-id', [
            dec.h('div', [
              new RawHtml({html: `<img src="https://files.coinmarketcap.com/static/img/coins/32x32/${attrs.cryptocurrency_id}.png" />`}),
              dec.h('span.crypto-name', attrs.cryptocurrency_name),
              dec.h('span.crypto-symbol', attrs.cryptocurrency_symbol)
            ]),
            dec.h('div',[
              dec.h('span.crypto-bookmark', attrs.cryptocurrency_name),
              dec.h('span.crypto-rank', I18n.t("cryptocurrency_rank") + " " + attrs.cryptocurrency_rank)
            ])
          ]),
          dec.h('div.crypto-data', [
            dec.h('div', [
              dec.h('div'[
                dec.h('span.crypto-price-usd', attrs.cryptocurrency_price_usd),
                dec.h('span.crypto-change-24h', attrs.cryptocurrency_percent_change_24h)
              ]),
              dec.h('div', [
                dec.h('span.crypto-price-btc', attrs.cryptocurrency_price_btc)
              ])
            ]),
            dec.h('hr'),
            dec.h('div.crypto-table', [
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_market_cap_usd")),
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_24h_volume_usd")),
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_available_supply")),
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_total_supply"))
            ]),
            dec.h('hr'),
            dec.h('div.crypto-table', [
              dec.h('span.crypto-table-cell', attrs.cryptocurrency_market_cap_usd),
              dec.h('span.crypto-table-cell', attrs.cryptocurrency_24h_volume_usd),
              dec.h('span.crypto-table-cell', attrs.cryptocurrency_available_supply),
              dec.h('span.crypto-table-cell', attrs.cryptocurrency_total_supply)
            ])
          ])
        ])];
    }
  });

  api.modifyClass('component:topic-list', {
    filter() {
      let filter = this.get('parentView.model.filter');
      if (filter == "home") {
        return true;
      } 
      else {
        return false;
      };
    },

    @computed('currentRoute')
    cryptoList() {
      return this.filter() && Discourse.SiteSettings.cryptocurrencies_enabled;
    },
  });
}

export default {
  name: 'extend-for-cryptocurrencies',
  initialize(container) {

    withPluginApi('0.8.4', api => {
      initialize(api, container);
    });
  }
};


