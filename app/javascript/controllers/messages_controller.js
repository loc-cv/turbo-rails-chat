import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="messages"
export default class extends Controller {
  connect() {
    this.resetScroll();
    messages.addEventListener('DOMNodeInserted', this.resetScroll);
  }

  disconnect() {
    messages.removeEventListener('DOMNodeInserted', this.resetScroll);
  }

  resetScroll() {
    messages.scrollTop = messages.scrollHeight - messages.clientHeight;
  }
}
