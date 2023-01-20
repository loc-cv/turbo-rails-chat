import consumer from 'channels/consumer';

let timer = 0;

consumer.subscriptions.create('AppearanceChannel', {
  // Called once when the subscription is created.
  initialized() {
    this.updateStatus = this.updateStatus.bind(this);
  },

  // Called when the subscription is ready for use on the server
  connected() {
    this.install();
  },

  // Called when the subscription has been terminated by the server
  disconnected() {
    this.uninstall();
  },

  // Called when there's incoming data on the websocket for this channel
  received(data) {},

  online() {
    this.perform('online');
  },

  offline() {
    this.perform('offline');
  },

  away() {
    this.perform('away');
  },

  install() {
    window.addEventListener('load', this.updateStatus);
    window.addEventListener('turbo:load', this.updateStatus);
    window.addEventListener('DOMContentLoaded', this.updateStatus);
    window.addEventListener('click', this.updateStatus);
    window.addEventListener('keydown', this.updateStatus);
    window.addEventListener('visibilitychange', this.updateStatus);
    window.addEventListener('focus', this.updateStatus);
    window.addEventListener('blur', this.updateStatus);
  },

  uninstall() {
    window.removeEventListener('load', this.updateStatus);
    window.removeEventListener('turbo:load', this.updateStatus);
    window.removeEventListener('DOMContentLoaded', this.updateStatus);
    window.removeEventListener('click', this.updateStatus);
    window.removeEventListener('keydown', this.updateStatus);
    window.removeEventListener('visibilitychange', this.updateStatus);
    window.removeEventListener('focus', this.updateStatus);
    window.removeEventListener('blur', this.updateStatus);
  },

  updateStatus() {
    const inRoomsIndex = document.getElementById('appearance_channel');
    clearTimeout(timer);
    if (inRoomsIndex) {
      this.online();
      timer = setTimeout(this.away.bind(this), 15 * 1000); // 15 seconds
    } else {
      this.offline();
    }
  },
});
