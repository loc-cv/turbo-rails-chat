import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="forms"
export default class extends Controller {
  clear() {
    this.element.reset();
  }
}
