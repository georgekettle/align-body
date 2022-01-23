# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@vimeo/player", to: "https://ga.jspm.io/npm:@vimeo/player@2.16.2/dist/player.es.js"
pin "flickity", to: "https://ga.jspm.io/npm:flickity@2.3.0/js/index.js"
pin "desandro-matches-selector", to: "https://ga.jspm.io/npm:desandro-matches-selector@2.0.2/matches-selector.js"
pin "ev-emitter", to: "https://ga.jspm.io/npm:ev-emitter@1.1.1/ev-emitter.js"
pin "fizzy-ui-utils", to: "https://ga.jspm.io/npm:fizzy-ui-utils@2.0.7/utils.js"
pin "get-size", to: "https://ga.jspm.io/npm:get-size@2.0.3/get-size.js"
pin "unidragger", to: "https://ga.jspm.io/npm:unidragger@2.4.0/unidragger.js"
pin "unipointer", to: "https://ga.jspm.io/npm:unipointer@2.4.0/unipointer.js"
