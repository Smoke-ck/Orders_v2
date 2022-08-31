// Entry point for the build script in your package.json
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "./controllers"

import 'bootstrap/js/dist/dropdown'
import 'bootstrap/js/dist/collapse'
import "@hotwired/turbo-rails"

Rails.start()
Turbolinks.start()
ActiveStorage.start()
