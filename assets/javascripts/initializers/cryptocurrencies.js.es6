import { withPluginApi } from 'discourse/lib/plugin-api';
import { default as computed, on, observes } from 'ember-addons/ember-computed-decorators';

function initialize(api) {
  api.decorateWidget('post-contents:after-cooked', dec => {
    return "";
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


