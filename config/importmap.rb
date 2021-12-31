# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@vimeo/player", to: "https://ga.jspm.io/npm:@vimeo/player@2.16.2/dist/player.es.js"
pin "uuid", to: "https://ga.jspm.io/npm:uuid@8.3.2/dist/esm-browser/index.js"
pin "recombee-js-api-client", to: "https://ga.jspm.io/npm:recombee-js-api-client@3.1.0/src/index.js"
pin "jssha", to: "https://ga.jspm.io/npm:jssha@2.4.2/src/sha.js"
