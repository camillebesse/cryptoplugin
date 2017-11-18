import { registerUnbound } from 'discourse-common/lib/helpers';

registerUnbound('list-bookmark', function(button, params) {
  var classes = 'topic-bookmark',
      title = 'bookmarks.not_bookmarked';
  if (this.get('topic.topic_post_bookmarked')) {
    classes += ' bookmarked';
    title = 'bookmarks.created';
  }
  var action = { class: classes, title: title, icon: 'star'};

  var html = "<button class='list-button " + action.class + "'";
  if (action.title) { html += 'title="' + I18n.t(action.title) + '"'; }
  if (action.disabled) {html += ' disabled';}
  html += "><i class='fa fa-" + action.icon + "' aria-hidden='true'></i>";
  html += "</button>";
  return new Handlebars.SafeString(html);
});