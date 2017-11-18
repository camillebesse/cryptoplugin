import { registerUnbound } from 'discourse-common/lib/helpers';

registerUnbound('format-percentage', function(value, options) {
  return value + '%';
});