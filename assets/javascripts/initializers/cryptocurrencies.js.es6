import loadScript from 'discourse/lib/load-script';
import { withPluginApi } from 'discourse/lib/plugin-api';

function initialize(api) {
console.log("init");
    api.onPageChange(()=> {
      loadScript("https://files.coinmarketcap.com/static/widget/currency.js");
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


