export function setup(helper) {
  helper.whiteList([ 'div[class=*]',
                    'div[data-currency]',
                    'div[data-base]',
                    'div[data-secondary]',
                    'div[data-ticker]',
                    'div[data-rank]',
                    'div[data-marketcap]',
                    'div[data-volume]',
                    'div[data-stats]', 
                    'div[data-statsticker]',
                    'script',
                    'script[type]',
                    'script[src]']);
}