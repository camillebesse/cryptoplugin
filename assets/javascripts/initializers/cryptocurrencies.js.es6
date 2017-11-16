import { withPluginApi } from 'discourse/lib/plugin-api';

function initialize(api) {
  api.decorateWidget('post-contents:after-cooked', dec => {
    console.log('post');
    console.log(dec);
  })

  api.decorateWidget('topic-status:after', dec => {
    console.log('status');
    console.log(dec);
    return "hello"
  })
}

export default {
  name: 'extend-for-cryptocurrencies',
  initialize(container) {

    withPluginApi('0.8.4', api => {
      initialize(api, container);
    });
  }
};


