import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if ('Notification' in window) {
      Notification.requestPermission().then(function(permission) {
        if (permission === 'granted') {
          console.log('Korisnik je dozvolio push notifikacije.');
        } else if (permission === 'denied') {
          console.warn('Korisnik je odbio push notifikacije.');
        }
      });
    }
  }
}


