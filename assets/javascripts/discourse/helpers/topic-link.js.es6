import { registerUnbound } from 'discourse-common/lib/helpers';

registerUnbound('topic-link', (topic, args) => {
  var title = topic.get('fancyTitle');

  var cryptoImg = ""
  if (topic.cryptocurrency_id){
    cryptoImg = `<img src="https://files.coinmarketcap.com/static/img/coins/32x32/${topic.cryptocurrency_id}.png" class="crypto-title-icon" />`;
    if (!title.startsWith(cryptoImg)){
      title = cryptoImg + " " + title;
      topic.set('fancyTitle', title);
    }
  }

  const url = topic.linked_post_number ?
    topic.urlForPostNumber(topic.linked_post_number) :
    topic.get('lastUnreadUrl');

  const classes = ['title'];
  if (args.class) {
    args.class.split(" ").forEach(c => classes.push(c));
  }

  const result = `<a href='${url}' class='${classes.join(' ')}'>${title}</a>`;
  
  return new Handlebars.SafeString(result);
});