import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'


export default class extends Controller {
  connect() {
    document.querySelectorAll('select:not([data-ssid])').forEach(e => { new SlimSelect({ select: e }) });
  }
}
