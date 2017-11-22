import { withPluginApi } from 'discourse/lib/plugin-api';
import { default as computed, on, observes } from 'ember-addons/ember-computed-decorators';
import RawHtml from 'discourse/widgets/raw-html';

function initialize(api) {
  api.includePostAttributes('topic_custom_fields');

  api.decorateWidget('post-contents:after-cooked', dec => {

    if (dec.attrs.firstPost){
      var attrs = dec.attrs.topic_custom_fields;

      var value = attrs.cryptocurrency_price_usd.toString();
      var amount = value.split(".");
      amount[1] = (amount[1] + "000").substring(0,2);
      attrs.cryptocurrency_price_usd = amount[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "." + amount[1];

      var value = attrs.cryptocurrency_market_cap_usd.toString();
      var amount = value.split(".");
      attrs.cryptocurrency_market_cap_usd = amount[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

      value = attrs.cryptocurrency_24h_volume_usd.toString();
      var amount = value.split(".");
      attrs.cryptocurrency_24h_volume_usd = amount[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

      value = attrs.cryptocurrency_available_supply.toString();
      var amount = value.split(".");
      attrs.cryptocurrency_available_supply = amount[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

      value = attrs.cryptocurrency_total_supply.toString();
      var amount = value.split(".");
      attrs.cryptocurrency_total_supply = amount[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

      if ( attrs.cryptocurrency_percent_change_24h < 0 ) {
        attrs.cryptocurrency_percent_change_24h_state = "negative";
      }
      else {
        attrs.cryptocurrency_percent_change_24h_state = "positive"; 
      }

      return [dec.h("div.cryptocurrency-custom-widget", [
          dec.h('div.crypto-widget-id', [
            dec.h('div', [
              new RawHtml({html: `<img src="https://files.coinmarketcap.com/static/img/coins/32x32/${attrs.cryptocurrency_id}.png" />`}),
              dec.h('span.crypto-name', attrs.cryptocurrency_name),
              dec.h('span.crypto-symbol', "(" + attrs.cryptocurrency_symbol + ")")
            ]),
            dec.h('div.crypto-rank',[
              dec.h('span', I18n.t("cryptocurrency_rank") + " " + attrs.cryptocurrency_rank)
            ])
          ]),
          dec.h('div.crypto-data', [
            dec.h('div', [
              dec.h('div', [
                dec.h('span.crypto-price-usd', "$" + attrs.cryptocurrency_price_usd),
                dec.h('span.crypto-change-24h.crypto-percentage.' + attrs.cryptocurrency_percent_change_24h_state, "(" + attrs.cryptocurrency_percent_change_24h + "%)")
              ])
            ]),
            dec.h('hr'),
            dec.h('div.crypto-table.crypto-table-header', [
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_market_cap_usd")),
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_24h_volume_usd")),
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_available_supply")),
              dec.h('span.crypto-table-cell', I18n.t("cryptocurrency_total_supply"))
            ]),
            dec.h('hr'),
            dec.h('div.crypto-table', [
              dec.h('span.crypto-table-cell', "$" + attrs.cryptocurrency_market_cap_usd),
              dec.h('span.crypto-table-cell', "$" + attrs.cryptocurrency_24h_volume_usd),
              dec.h('span.crypto-table-cell', attrs.cryptocurrency_available_supply + " " + attrs.cryptocurrency_symbol),
              dec.h('span.crypto-table-cell', attrs.cryptocurrency_total_supply + " " + attrs.cryptocurrency_symbol)
            ])
          ])
        ])];
    }
  });

  api.modifyClass('component:topic-list', {
    filter() {
      let filter = this.get('parentView.model.filter');
      if (filter == "home" || filter == "favorites") {
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


