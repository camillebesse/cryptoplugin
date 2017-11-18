import { registerUnbound } from 'discourse-common/lib/helpers';

registerUnbound('percentage-state', function(value, options) {
  if ( value < 0 ) {
    var classes = "negative";
  }
  else {
    var classes = "positive";
  }
  return classes;
});