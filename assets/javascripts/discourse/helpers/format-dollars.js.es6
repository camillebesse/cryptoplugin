import { registerUnbound } from 'discourse-common/lib/helpers';

registerUnbound('format-dollars', function(value, options) {
  value = value.toString();
  var amount = value.split(".");
  
  amount[0] = amount[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

  if (amount[1] == undefined){
    amount[1] = "00";
  }
  else{
    amount[1] = (amount[1] + "000").substring(0,2);
  }
  
  if ( options.showCents == "true" ) {
    return "$" + amount[0] + "." + amount[1];
  }
  else {
    return "$" + amount[0];
  }
});